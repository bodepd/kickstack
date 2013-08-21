#
# define resource type that helps populate keystone endpoints
# for all of the services
#
define kickstack::endpoint (
  $service_password         = hiera("${name}_service_password"),
) {

  include pwgen

  $servicename = $name
  $factname = "${servicename}_keystone_password"
  $classname = "${servicename}::keystone::auth"

  # Installs the service user endpoint.
  class { "${classname}":
    password         => $service_password,
    public_address   => "${hostname}${::kickstack::keystone_public_suffix}",
    admin_address    => "${hostname}${::kickstack::keystone_admin_suffix}",
    internal_address => $hostname,
    region           => "$::kickstack::keystone_region",
    require          => Class['::keystone'],
  }

  data { "${name}_service_password":
    value => $service_password,
  }

}
