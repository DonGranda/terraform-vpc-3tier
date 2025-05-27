locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  subnet_configs = flatten([
    for az_index, az in local.azs : [
      {
        name              = "public-${az_index + 1}"
        cidr_suffix_index = az_index * 3 + 0
        az                = az
        type              = "public"
      },
      {
        name              = "private-${az_index + 1}-a"
        cidr_suffix_index = az_index * 3 + 1
        az                = az
        type              = "private"
      },
      {
        name              = "private-${az_index + 1}-b"
        cidr_suffix_index = az_index * 3 + 2
        az                = az
        type              = "private"
      }
    ]
  ])
}

