# This script sets up a simple static website using Nginx for the ASG, with health checks and monitoring capabilities.
#!/bin/bash

# Exit on any error
set -e

# Update system packages
echo "Updating system packages..."
apt-get update -y

# Install Nginx
echo "Installing Nginx..."
apt-get install -y nginx

# Install other useful packages
echo "Installing additional packages..."
apt-get install -y curl wget unzip awscli

# Create a simple static website
echo "Creating static website content..."
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Static Website</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .container {
            text-align: center;
            max-width: 800px;
            padding: 2rem;
        }
        h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .subtitle {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }
        .server-info {
            background: rgba(255, 255, 255, 0.1);
            padding: 1rem;
            border-radius: 8px;
            margin-top: 2rem;
            backdrop-filter: blur(10px);
        }
        .status {
            color: #4CAF50;
            font-weight: bold;
        }
        .feature-list {
            list-style: none;
            padding: 0;
            margin: 2rem 0;
        }
        .feature-list li {
            padding: 0.5rem 0;
            font-size: 1.1rem;
        }
        .feature-list li:before {
            content: "✓ ";
            color: #4CAF50;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Welcome to My Static Website</h1>
        <p class="subtitle">Powered by Nginx on AWS Auto Scaling Group</p>
        
        <ul class="feature-list">
            <li>High Availability Architecture</li>
            <li>Auto Scaling Based on Load</li>
            <li>Load Balanced Traffic</li>
            <li>Secure & Scalable</li>
        </ul>
        
        <div class="server-info">
            <h3>Server Information</h3>
            <p><strong>Status:</strong> <span class="status">Online</span></p>
            <p><strong>Server:</strong> <span id="hostname">Loading...</span></p>
            <p><strong>Instance ID:</strong> <span id="instance-id">Loading...</span></p>
            <p><strong>Availability Zone:</strong> <span id="az">Loading...</span></p>
            <p><strong>Local IP:</strong> <span id="local-ip">Loading...</span></p>
            <p><strong>Load Time:</strong> <span id="timestamp"></span></p>
        </div>
    </div>

    <script>
        // Get server information
        document.getElementById('hostname').textContent = window.location.hostname;
        document.getElementById('timestamp').textContent = new Date().toLocaleString();
        
        // Fetch instance metadata (this will work on EC2 instances)
        fetch('http://169.254.169.254/latest/meta-data/instance-id')
            .then(response => response.text())
            .then(data => document.getElementById('instance-id').textContent = data)
            .catch(() => document.getElementById('instance-id').textContent = 'N/A');
            
        fetch('http://169.254.169.254/latest/meta-data/placement/availability-zone')
            .then(response => response.text())
            .then(data => document.getElementById('az').textContent = data)
            .catch(() => document.getElementById('az').textContent = 'N/A');
            
        fetch('http://169.254.169.254/latest/meta-data/local-ipv4')
            .then(response => response.text())
            .then(data => document.getElementById('local-ip').textContent = data)
            .catch(() => document.getElementById('local-ip').textContent = 'N/A');
    </script>
</body>
</html>
EOF

# Create a health check endpoint
echo "Creating health check endpoint..."
cat > /var/www/html/health << 'EOF'
OK
EOF

# Create a custom Nginx configuration
echo "Configuring Nginx..."
cat > /etc/nginx/sites-available/default << 'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    
    root /var/www/html;
    index index.html index.htm;
    
    server_name _;
    
    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;
    
    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied expired no-cache no-store private no_last_modified no_etag auth;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml+rss;
    
    # Main location
    location / {
        try_files $uri $uri/ =404;
    }
    
    # Health check endpoint
    location /health {
        access_log off;
        return 200 "OK\n";
        add_header Content-Type text/plain;
    }
    
    # Status endpoint for monitoring
    location /status {
        access_log off;
        return 200 '{"status":"healthy","timestamp":"$time_iso8601","server":"$hostname"}';
        add_header Content-Type application/json;
    }
    
    # Cache static assets
    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
    
    # Security - deny access to hidden files
    location ~ /\. {
        deny all;
    }
}
EOF

# Test Nginx configuration
echo "Testing Nginx configuration..."
nginx -t

# Enable and start Nginx
echo "Starting Nginx..."
systemctl enable nginx
systemctl start nginx

# Create a simple log rotation for custom logs
echo "Setting up log rotation..."
cat > /etc/logrotate.d/nginx-custom << 'EOF'
/var/log/nginx/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 644 www-data adm
    sharedscripts
    postrotate
        if [ -f /var/run/nginx.pid ]; then
            kill -USR1 `cat /var/run/nginx.pid`
        fi
    endscript
}
EOF

# Set proper permissions
echo "Setting file permissions..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Create a simple monitoring script
echo "Creating monitoring script..."
cat > /usr/local/bin/webapp-monitor.sh << 'EOF'
#!/bin/bash
# Simple health monitoring script

LOG_FILE="/var/log/webapp-monitor.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Check if Nginx is running
if systemctl is-active --quiet nginx; then
    echo "[$DATE] Nginx is running" >> $LOG_FILE
else
    echo "[$DATE] ERROR: Nginx is not running, attempting to restart" >> $LOG_FILE
    systemctl restart nginx
fi

# Check if the website is responding
if curl -s -o /dev/null -w "%{http_code}" http://localhost/health | grep -q "200"; then
    echo "[$DATE] Website health check passed" >> $LOG_FILE
else
    echo "[$DATE] ERROR: Website health check failed" >> $LOG_FILE
fi
EOF

chmod +x /usr/local/bin/webapp-monitor.sh

# Add monitoring to cron (run every 5 minutes)
echo "Setting up monitoring cron job..."
echo "*/5 * * * * root /usr/local/bin/webapp-monitor.sh" >> /etc/crontab

# Install CloudWatch agent (optional - for better monitoring)
echo "Installing CloudWatch agent..."
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb || true
apt-get install -f -y

# Clean up
echo "Cleaning up..."
apt-get autoremove -y
apt-get autoclean
rm -f amazon-cloudwatch-agent.deb

# Final status check
echo "Performing final status check..."
if systemctl is-active --quiet nginx; then
    echo "✅ SUCCESS: Nginx is running and configured"
    echo "✅ Website is available at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null || echo 'localhost')"
else
    echo "❌ ERROR: Nginx failed to start"
    exit 1
fi

# Log successful completion
echo "$(date): Web application setup completed successfully" >> /var/log/webapp-setup.log

echo "🚀 Web application setup complete!"
echo "📊 Monitor logs with: tail -f /var/log/webapp-monitor.log"
echo "🔍 Check Nginx status with: systemctl status nginx"