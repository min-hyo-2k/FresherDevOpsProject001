terraform {
  backend "s3" {
    bucket         = "tfstate-for-locking-hieutm2712" # Created & Versioning Enabled Manually.
    key            = "terraform.tfstate"   # path and name of state file.
    region         = "ap-southeast-1"
    dynamodb_table = "state_table" # name of dynamodb table for State Lock, must have partition key = "LockID"
    # encrypt = true # by default
  }
}