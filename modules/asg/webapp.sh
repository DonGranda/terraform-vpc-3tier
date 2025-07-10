#!/bin/bash
sudo apt update -y
          
sudo apt install -y nginx
           
sudo systemctl start nginx
sudo systemctl enable nginx
            
sudo apt install -y curl unzip
cd /var/www/html
sudo rm index.nginx-debian.html
sudo curl -o template.zip https://www.tooplate.com/zip-templates/2133_moso_interior.zip
sudo unzip template.zip -d /var/www/html/
sudo mv 2133_moso_interior/* .
sudo rm -rf template.zip 2133_moso_interior
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
sudo systemctl restart nginx
