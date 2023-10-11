terraform {
  required_version = ">=1.3.1"
}

locals {

  location_abbr = lookup(local.location_map, var.location)
  env_abbr      = lookup(local.environment_map, var.environment)
  prefix_parts  = [var.product_area, "${local.env_abbr}${local.location_abbr}"]
  prefix        = join("-", local.prefix_parts)

  # Create equivalent "generator" map for "pseudo resource types"
  # If a resource does not have a related "pseudo resource", just use the resource itself (makes merging maps easier)
  pseudo_resources_generator = { for
    domain, resources in var.generator : domain => { for
      type, count in resources : try(keys(local.pseudo_resource_types[type])[0], type) => count
    }
  }

  # Generator configuration for resources and pseudo resources
  generator_config = { for
    domain, resources in var.generator : domain => { for
      type, count in merge(resources, local.pseudo_resources_generator[domain]) : type => {
        count     = count
        type      = type
        separator = tobool(local.all_resource_types[type].alphanum) ? "" : "-"
        name_parts = compact(flatten([
          local.prefix_parts,
          domain,
          local.all_resource_types[type].abbr
        ]))
        max_name_length = try(local.all_resource_types[type].max_name_length, -1)
        index_format    = try(local.all_resource_types[type].index_format, "%03d")
      }
    }
  }

  generated_names = { for
    domain, resources in local.generator_config : domain => { for # for each key (a.k.a. domain) in the "generator" map
      type, config in resources : type => [for                    # for each "resource_type" in the domain
        index in range(1, config.count + 1) :
        "${substr(join(config.separator, config.name_parts), 0, config.max_name_length)}${format(config.index_format, index)}"
    ] }
  }
}
