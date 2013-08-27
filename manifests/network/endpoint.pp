#
# This class cannot use the endpoint define b/c it needs to be
# able to select either quantum or neutron as the network service provider
#
class kickstack::network::endpoint (
  $service_password         = hiera('network_service_password'),
  $service_public_address   = hiera('network_public_address'),
  $service_admin_address    = hiera('network_admin_address', hiera('network_public_address')),
  $service_internal_address = hiera('network_internal_address', hiera('network_public_address')),
  $service_tenant           = hiera('service_tenant', 'services'),
  $service_region           = hiera('region', 'RegionOne'),
) inherits kickstack {

  class { "::${::kickstack::network_service}::keystone::auth":
    password         => $service_password,
    public_address   => $service_public_address,
    admin_address    => $service_admin_address,
    internal_address => $service_internal_address,
    region           => $service_region,
    tenant           => $service_tenant,
    require          => Class['::keystone'],
  }

  data { 'network_service_password':
    value => $service_password,
  }

}
