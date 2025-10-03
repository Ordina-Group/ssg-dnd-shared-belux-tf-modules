variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "subnets" {
  description = "Subnets to create EFS in"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Security Groups allowed to access EFS"
  type        = list(string)
}

variable "eks_cluster_id" {
  description = "EKS cluster ID"
  type        = string
}
