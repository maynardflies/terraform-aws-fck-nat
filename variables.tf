variable "name" {
  description = "Name used for resources created within the module"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to deploy the NAT instance into"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to deploy the NAT instance into"
  type        = string
}

variable "update_route_table" {
  description = "Whether or not to update the route table with the NAT instance"
  type        = bool
  default     = false
}

variable "route_table_id" {
  description = "Route table to update. Only valid if update_route_table is true"
  type        = string
  default     = null
}

variable "encryption" {
  description = "Whether or not to encrypt the EBS volume"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "Will use the provided KMS key ID to encrypt the EBS volume. Uses the default KMS key if none provided"
  type        = string
  default     = null
}

variable "ha_mode" {
  description = "Whether or not high-availability mode should be enabled via autoscaling group"
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "Instance type to use for the NAT instance"
  type        = string
  default     = "t4g.micro"
}

variable "ami_id" {
  description = "AMI to use for the NAT instance. Uses fck-nat latest AMI in the region if none provided"
  type        = string
  default     = null
}

variable "ebs_root_volume_size" {
  description = "Size of the EBS root volume in GB"
  type        = number
  default     = 2
}

variable "eip_allocation_ids" {
  description = "EIP allocation IDs to use for the NAT instance. Automatically assign a public IP if none is provided. Note: Currently only supports at most one EIP allocation."
  type        = list(string)
  default     = []
}

variable "use_spot_instances" {
  description = "Whether or not to use spot instances for running the NAT instance"
  type        = bool
  default     = false
}

variable "use_cloudwatch_agent" {
  description = "Whether or not to enable CloudWatch agent for the NAT instance"
  type        = bool
  default     = false
}

variable "cloudwatch_agent_configuration" {
  description = "CloudWatch configuration for the NAT instance"
  type = object({
    namespace           = optional(string, "fck-nat"),
    collection_interval = optional(number, 60),
    endpoint_override   = optional(string, "")
  })
  default = {
    namespace           = "fck-nat"
    collection_interval = 60
    endpoint_override   = ""
  }
}

variable "cloudwatch_agent_configuration_param_arn" {
  description = "ARN of the SSM parameter containing the CloudWatch agent configuration. If none provided, creates one"
  type        = string
  default     = null
}

variable "use_nat64" {
  description = "Whether or not to enable NAT64 on the NAT instance. Your VPC and at least the public subnet this NAT instance is deployed into must support IPv6"
  type        = bool
  default     = false
}

variable "nat64_configuration" {
  description = "NAT64 configuration for the NAT instance through TAYGA"
  type = object({
    tayga_ipv4_addr    = optional(string, "192.168.255.1"),
    tayga_ipv6_addr    = optional(string, "2001:db8:1::2"),
    tayga_dynamic_pool = optional(string, "192.168.0.0/16"),
  })
  default = {
    default = {
      tayga_ipv4_addr    = "192.168.255.1",
      tayga_ipv6_addr    = "2001:db8:1::2",
      tayga_dynamic_pool = "192.168.0.0/16"
    }
  }
}

variable "tags" {
  description = "Tags to apply to resources created within the module"
  type        = map(string)
  default     = {}
}