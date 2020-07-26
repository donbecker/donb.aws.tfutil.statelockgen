output "Statelock_config" {
    value = [
        "terraform { backend \"s3\" { bucket = \"${aws_s3_bucket.s3b.id}\", encrypt = true, dynamodb_table = \"${aws_dynamodb_table.ddb.id}\", key = \"terraform.tfstate\", region = \"${var.aws_region}\"}}"
    ]
}