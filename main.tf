locals {
    l_tags = tomap({
        project = "donb.aws.tfutil.statelockgen",
        env = "${var.env_name}"
    })
}

provider "aws" {
    region = var.aws_region
    profile = var.aws_profile
}
resource "random_id" "random" {
    byte_length = 4
}

resource "aws_s3_bucket" "s3b" {
    bucket = "tfsl-${var.env_name}-${random_id.random.hex}"
    versioning { enabled = true }
    lifecycle { prevent_destroy = true}
    tags = merge(
        local.l_tags,
        {
            "Name" = "tfsl-${var.env_name}-${random_id.random.hex}"
        }
    )  
}

resource "aws_dynamodb_table" "ddb" {
    read_capacity = 5
    write_capacity = 5
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    name = "tfsl-${var.env_name}-${random_id.random.hex}"
    tags = merge(
        local.l_tags,
        {
            "Name" = "tfsl-${var.env_name}-${random_id.random.hex}"
        }
    )  
}