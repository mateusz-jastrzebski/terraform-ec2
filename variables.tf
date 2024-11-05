variable "aws_region" {
  type        = string
  description = "aws region"
}

variable "aws_access_key" {
  type        = string
  description = "aws access key"
}

variable "aws_secret_key" {
  type        = string
  description = "aws secret key"
}

variable "cloudflare_email" {
  type        = string
  description = "clouflare email address"
}

variable "cloudflare_api_token" {
  type        = string
  description = "cloudflare api token"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "cloudflare api token"
}

variable "key_name" {
  type        = string
  description = "AWS private key name"
}

variable "user_name" {
  type        = string
  description = "The name to display on the website"
  default     = "XYZ"
}