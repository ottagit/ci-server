# Tell Terraform which service to use for resource setup
provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Owner     = "Chris Otta"
    }
  }
}

module "jenkins_server" {
  source = "github.com/ottagit/modules//ci-cd/jenkins-server?ref=v0.1.2"

  ami_name          = "Jenkins Instance"
  ami_id            = "ami-0230bd60aa48260c6"
  ami_key_pair_name = "testenv"
  name              = "jenkins-instance-role"
  dynamo_db_table   = "terraone-locks"
  s3_bucket_name    = "batoto-bitange"
  path_to_key       = "global/s3/terraform-jenkins.tfstate"
}

terraform {
  backend "s3" {
    key = "stage/ci-servers/jenkins/terraform.tfstate"

    bucket = "batoto-bitange"
    region = "us-east-1"

    dynamodb_table = "terraone-locks"
    encrypt        = true
  }
}
