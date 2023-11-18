locals {
  name         = "fck-nat-example"
  vpc_cidr     = "10.255.255.0/24"
  ipv6_support = true
}

data "aws_region" "current" {}

module "fck-nat" {
  source = "../../"

  name               = local.name
  vpc_id             = aws_vpc.main.id
  subnet_id          = aws_subnet.public.id
  update_route_table = true
  route_table_id     = aws_route_table.private.id
  ha_mode            = false
  use_nat64          = local.ipv6_support
}

resource "aws_route" "ipv6_route" {
  count = local.ipv6_support ? 1 : 0

  # Is there only because for some reason I made the parameter `route_table_id` take only one ID instead of an array of
  # IDs as multiple subnets might depend on a single NAT instance. This is not fixed yet as it would break
  # compatibility. Will be fixed in v2.

  route_table_id              = aws_route_table.private_ipv6[0].id
  destination_ipv6_cidr_block = "64:ff9b::/96"
  network_interface_id        = module.fck-nat.eni_id
}