locals {

  environment_map = {
    test = "tt"
    gaz  = "gz"
  }

  location_map = {
    eastasia           = "ae"
    southeastasia      = "ase"
    brazilsouth        = "brs"
    canadacentral      = "cac"
    canadaeast         = "cae"
    chinaeast          = "ce"
    chinaeast2         = "ce2"
    chinanorth         = "cn"
    chinanorth2        = "cn2"
    northeurope        = "en"
    westeurope         = "ew"
    francecentral      = "fc"
    francesouth        = "fs"
    global             = "gl"
    germanycentral     = "gc"
    germanynorth       = "gn"
    germanynortheast   = "gne"
    germanywestcentral = "gwc"
    centralindia       = "ic"
    southindia         = "is"
    westindia          = "iw"
    japaneast          = "je"
    japanwest          = "jw"
    koreacentral       = "kc"
    koreasouth         = "ks"
    norwayeast         = "ne"
    norwaywest         = "nw"
    australiacentral   = "rc"
    australiacentral2  = "rc2"
    australiaeast      = "re"
    australiasoutheast = "rse"
    southafricanorth   = "san"
    southafricawest    = "saw"
    switzerlandnorth   = "swn"
    switzerlandwest    = "sww"
    uaecentral         = "uac"
    usgovarizona       = "uag"
    uaenorth           = "uan"
    centralus          = "uc"
    usdodcentral       = "ucd"
    eastus             = "ue"
    eastus2            = "ue2"
    usdodeast          = "ued"
    usgoviowa          = "uig"
    uksouth            = "uks"
    ukwest             = "ukw"
    northcentralus     = "unc"
    southcentralus     = "usc"
    usgovtexas         = "utg"
    usgovvirginia      = "uvg"
    westus             = "uw"
    westus2            = "us"
    westcentralus      = "us"
    notapplicable      = ""
    worldwide          = "ww-"
  }

  resource_types = {
    availability_set = {
      name     = "availability_set"
      alphanum = false
      global   = false
      abbr     = "as"
    }
    active_directory_domain_services = {
      name     = "active_directory_domain_services"
      alphanum = false
      global   = false
      abbr     = "adds"
    }
    app_service_plan = {
      name     = "app_service_plan"
      alphanum = false
      global   = false
      abbr     = "asp"
    }
    bastion_host = {
      name     = "bastion_host"
      alphanum = false
      global   = false
      abbr     = "bas"
    }
    compute_gallery = {
      name     = "compute_gallery"
      alphanum = true
      global   = false
      abbr     = "gal"
    }
    cosmosdb_account = {
      name     = "cosmosdb_account"
      alphanum = false
      global   = false
      abbr     = "cdb"
    }
    firewall = {
      name     = "firewall"
      alphanum = false
      global   = false
      abbr     = "afw"
    }
    firewall_policy = {
      name     = "firewall_policy"
      alphanum = false
      global   = false
      abbr     = "afwp"
    }
    function_app = {
      name     = "function_app"
      alphanum = false
      global   = false
      abbr     = "func"
    }
    kubernetes_cluster = {
      name     = "kubernetes_cluster"
      alphanum = false
      global   = false
      abbr     = "aks"
    }
    express_route_circuit = {
      name     = "express_route_circuit"
      alphanum = false
      global   = false
      abbr     = "erc"
    }
    express_route_gateway = {
      name     = "express_route_gateway"
      alphanum = false
      global   = false
      abbr     = "egw"
    }
    key_vault = {
      name     = "key_vault"
      alphanum = false
      global   = false
      abbr     = "kv"
    }
    key_vault_certificate = {
      name     = "key_vault_certificate"
      alphanum = false
      global   = false
      abbr     = "kvcert"
    }
    key_vault_key = {
      name     = "key_vault_key"
      alphanum = false
      global   = false
      abbr     = "kvk"
    }
    key_vault_secret = {
      name     = "key_vault_secret"
      alphanum = false
      global   = false
      abbr     = "kvs"
    }
    ip_group = {
      name     = "ip_group"
      alphanum = false
      global   = false
      abbr     = "ipg"
    }
    log_analytics_workspace = {
      name     = "log_analytics_workspace"
      alphanum = false
      global   = false
      abbr     = "log"
    }
    managed_disk = {
      name     = "managed_disk"
      alphanum = false
      global   = false
      abbr     = "disk"
    }
    managed_identity = {
      name     = "managed_identity"
      alphanum = false
      global   = false
      abbr     = "mid"
    }
    management_group = {
      name     = "management_group"
      alphanum = false
      global   = false
      abbr     = "mg"
    }
    nat_gateway = {
      name     = "nat_gateway"
      alphanum = false
      global   = false
      abbr     = "natgw"
    }
    network_ddos_protection_plan = {
      name     = "network_ddos_protection_plan"
      alphanum = false
      global   = false
      abbr     = "ddp"
    }
    network_interface = {
      name     = "network_interface"
      alphanum = false
      global   = false
      abbr     = "nic"
    }
    network_security_group = {
      name     = "network_security_group"
      alphanum = false
      global   = false
      abbr     = "nsg"
    }
    network_watcher = {
      name     = "network_watcher"
      alphanum = false
      global   = false
      abbr     = "nw"
    }
    network_watcher_flow_log = {
      name     = "network_watcher_flow_log"
      alphanum = false
      global   = false
      abbr     = "flow"
    }
    portal_dashboard = {
      name     = "portal_dashboard"
      alphanum = false
      global   = false
      abbr     = "pdb"
    }
    private_dns_a_record = {
      name     = "private_dns_a_record"
      alphanum = false
      global   = false
      abbr     = "pdnsar"
    }
    private_endpoint = {
      name     = "private_endpoint"
      alphanum = false
      global   = false
      abbr     = "pe"
    }
    public_ip = {
      name     = "public_ip"
      alphanum = false
      global   = false
      abbr     = "pip"
    }
    public_ip_prefix = {
      name     = "public_ip_prefix"
      alphanum = false
      global   = false
      abbr     = "ippre"
    }
    resource_group = {
      name     = "resource_group"
      alphanum = false
      global   = false
      abbr     = "rg"
    }
    servicebus_namespace = {
      name     = "servicebus_namespace"
      alphanum = false
      global   = false
      abbr     = "sbn"
    }
    servicebus_queue = {
      name     = "servicebus_queue"
      alphanum = false
      global   = false
      abbr     = "sbq"
    }
    storage_account = {
      name     = "storage_account"
      alphanum = true
      global   = true
      abbr     = "sa"
    }
    storage_blob = {
      name     = "storage_blob"
      alphanum = true
      global   = true
      abbr     = "sb"
    }
    storage_container = {
      name     = "storage_container"
      alphanum = true
      global   = true
      abbr     = "sc"
    }
    storage_management_policy = {
      name     = "storage_management_policy"
      alphanum = true
      global   = true
      abbr     = "samp"
    }
    storage_account_network_rules = {
      name     = "storage_account_network_rules"
      alphanum = true
      global   = true
      abbr     = "sanr"
    }
    subnet = {
      name     = "subnet"
      alphanum = false
      global   = false
      abbr     = "snet"
    }
    subscription = {
      name     = "subscription"
      alphanum = false
      global   = false
      abbr     = "sub"
    }
    route_table = {
      name     = "route_table"
      alphanum = false
      global   = false
      abbr     = "udr"
    }
    user_assigned_identity = {
      name     = "user_assigned_identity"
      alphanum = false
      global   = false
      abbr     = "id"
    }
    virtual_machine = {
      name     = "virtual_machine"
      alphanum = false
      global   = false
      abbr     = "vm"
    }
    virtual_machine_scale_set = {
      name     = "virtual_machine_scale_set"
      alphanum = false
      global   = false
      abbr     = "ss"
    }
    virtual_network = {
      name     = "virtual_network"
      alphanum = false
      global   = false
      abbr     = "vnet"
    }
    vpn_gateway = {
      name     = "vpn_gateway"
      alphanum = false
      global   = false
      abbr     = "vpn"
    }
  }

  # Pseudo-resource (the names are derived from resource types)
  pseudo_resource_types = {
    virtual_machine = {
      computer_name = {
        name            = "computer_name"
        alphanum        = true
        global          = true
        abbr            = "" # Empty abbreviation
        max_name_length = 13
        index_format    = "%02d"
      }
    }
  }

  # Resource configuration: Includes resource types and "pseudo resource types"
  all_resource_types = merge(
    local.resource_types,
    local.pseudo_resource_types.virtual_machine # a.k.a. { computer_name = { name = ..., } }
  )
}
