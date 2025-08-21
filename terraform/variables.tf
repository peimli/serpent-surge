# EC2 and SSH
variable "key_pair_name" {
  description = "Name of the EC2 key pair"
  type        = string
  default     = "serpent-surge-key"
}

# Database settings
variable "db_user" {
  description = "Username for the RDS database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  default     = "adminpassword"
  sensitive   = true
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "serpent_surge_db"
}

variable "table_name" {
  description = "The table inside the database to back up"
  type        = string
  default     = "score"
}

# AWS region
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_prefix" {
  description = "Prefix for S3 bucket name"
  type        = string
  default     = "serpent-surge-backups"
}

variable "project" {
  type        = string
  description = "Project name used in tags and resource names"
  default     = "serpent-surge"
}

