include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:upside-services/aws-config-terraform.git//modules/vpc/vpc/community-v1.49.0"
}

inputs = {
  name = "upside-us-east-3"
  cidr = "10.201.0.0/16"
  // there is no us-east-1e because i kept getting this error in terragrunt:
  //* aws_eks_cluster.this: error creating EKS Cluster (little-dipper): UnsupportedAvailabilityZoneException: Cannot create cluster 'little-dipper' because us-east-1e, the targeted availability zone, does not currently have sufficient capacity to support the cluster. Retry and choose from these availability zones: us-east-1a, us-east-1b, us-east-1c, us-east-1d, us-east-1f
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1f"]
  private_subnets = ["10.201.1.0/20", "10.201.16.0/20", "10.201.32.0/20", "10.201.48.0/20", "10.201.80.0/20"]
  public_subnets  = ["10.201.101.0/24", "10.201.208.0/24", "10.201.224.0/24", "10.201.240.0/24", "10.201.252.0/24"]
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames = true
  enable_nat_gateway = true
  single_nat_gateway = true
  tags = {
  Owner       = "prod"
  Environment = "prod"
  vpc_tags = {
  Name = "upside-us-east-3"
  public_subnet_tags = {
  Visibility = "public"
  private_subnet_tags = {
  "kubernetes.io/role/internal-elb" = "1"
  Visibility = "private"
}

