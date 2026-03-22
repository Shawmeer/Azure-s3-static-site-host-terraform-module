variable "bucket_name" {
  default = "samir-module-s3-bucket-hosting"
  type    = string
}
variable "index_document" {
  default = "index.html"
  type    = string
}
variable "error_document" {
  default = "error.html"
  type    = string
}
variable "region" {
  default = "ap-south-1"
  type    = string
}