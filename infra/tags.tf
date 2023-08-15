locals {
  common_tags = {
    Environment = var.environment
    CreatedDate = timestamp()
  }
}