module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "${local.name}-vpc"
  cidr = local.vpc_cidr

  azs = local.azs
  private_subnets = local.private_subnet
  public_subnets = local.public_subnet
  intra_subnets = local.intra_subnet

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    terraform = true
    Environment = local.env
  }



}
