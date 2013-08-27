#
class kickstack::network::server(
  $service_password = hiera('network_service_password'),
  $service_user     = hiera('network_service_user', $::kickstack::network_service),
  $auth_host        = hiera('keystone_internal_address', '127.0.0.1'),
  $management_nic   = hiera('management_nic', $::kickstack::management_nic),
  $service_tenant   = hiera('service_tenant', $::kickstack::auth_service_tenant),
) inherits kickstack {

  include kickstack::network::config

  class { "${::kickstack::network_service}::server":
    auth_tenant   => $service_tenant,
    auth_user     => $service_user,
    auth_password => $service_password,
    auth_host     => $auth_host,
  }

  data { 'network_host':
    value => get_ip_from_nic($management_nic),
  }

}
