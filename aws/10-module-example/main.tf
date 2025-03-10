provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-053b0d53c279acc90" # replace this
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-02068492068419c37" # replace this
}

output "ami_instance" {
  value = module.ec2_instance.public-ip-address
}