variable "name" {
  description = "The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster. Possible values must begin and end with a letter or number, contain only letters, numbers, and hyphens and be between 1 and 54 characters in length. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free, Paid and Standard (which includes the Uptime SLA)."
  type        = string
  default     = "Standard"
}

variable "authorized_ip_ranges" {
  description = "Set of authorized IP ranges to allow access to API server, e.g. [\"198.51.100.0/24\"]."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

#####################################################################
#################### default_node_pool variables ####################
#####################################################################

variable "default_node_pool_name" {
  description = "The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created."
  type        = string
  default     = "default"
}

variable "vm_size" {
  description = "The size of the Virtual Machine, such as Standard_D2a_v4."
  type        = string
  default     = "Standard_D2a_v4"
}

variable "max_pods" {
  description = "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = 32
}

variable "enable_auto_scaling" {
  description = "Should the Kubernetes Auto Scaler be enabled for this Node Pool?"
  type        = bool
  default     = true
}

variable "node_count" {
  description = "The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count."
  type        = number
  default     = 1
}

variable "min_count" {
  description = "The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000."
  type        = number
  default     = 1
}

variable "max_count" {
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000."
  type        = number
  default     = 3
}

variable "vnet_subnet_id" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "availability_zones" {
  description = "Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created. Like: ['1', '2', '3']"
  type        = list(string)
  default     = null
}

#######################################################################
#################### kv secrets provider variables ####################
#######################################################################

variable "secret_rotation_enabled" {
  description = "Should the secret store CSI driver on the AKS cluster be enabled?"
  type        = bool
  default     = false
}

variable "secret_rotation_interval" {
  description = "The interval to poll for secret rotation. This attribute is only set when secret_rotation is true and defaults to 2m."
  type        = string
  default     = "2m"
}

###################################################################
#################### network profile variables ####################
###################################################################

variable "network_plugin" {
  description = "Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created."
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. NOTE: When network_policy is set to azure, the network_plugin field can only be set to azure."
  type        = string
  default     = "azure"
}

variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard."
  type        = string
  default     = "standard"
}

variable "outbound_ip_address_ids" {
  description = "The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer."
  type        = list(string)
  default     = []
}

###########################################################
#################### HTTP PROXY CONFIG ####################
###########################################################

variable "set_http_proxy_config" {
  description = "Will the AKS set an HTTP Proxy config?"
  type        = bool
  default     = false
}

variable "http_proxy" {
  description = "The proxy address to be used when communicating over HTTP. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "https_proxy" {
  description = "The proxy address to be used when communicating over HTTPS. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "no_proxy" {
  description = "The list of domains that will not use the proxy for communication."
  type        = list(string)
  default     = []
}

variable "trusted_ca" {
  description = "The base64 encoded alternative CA certificate content in PEM format."
  type        = string
  default     = null
}
