module "example_s3_bucket" {
  source      = "../modules/s3-simple-example"
  bucket_name = local.environment == "production" ? "buscket-production" : "bucket-staging"
}