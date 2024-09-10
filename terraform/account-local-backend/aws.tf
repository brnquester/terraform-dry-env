provider "aws" {
  region  = "us-east-2"
  profile = local.profile

  default_tags {
    tags = {
      Environment = local.environment
    }
  }
}

provider "aws" {
  region  = "us-east-2"
  alias   = "ohio"
  profile = local.profile
}
