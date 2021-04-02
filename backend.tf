terraform {
    backend "s3" {
        bucket  = "rossw-backend"
        key     = "rossw-blog.tfstate"
        region  = "eu-west-2"
    }
}