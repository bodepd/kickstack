#
class kickstack::nova::networkclient(
  $auth_host             = hiera('auth_internal_address', '127.0.0.1'),
  $network_auth_password = hiera('network_service_password'),
  $network_auth_username = hiera('network_service_username', $::kickstack::network_service),
  $network_host          = hiera('network_internal_address', '127.0.0.1'),
) inherits kickstack {

  include kickstack::nova::config

  if $::kickstack::network_service == 'quantum' {
    class { '::nova::network::quantum':
      quantum_admin_password    => $network_auth_password,
      quantum_auth_strategy     => 'keystone',
      quantum_url               => "http://${network_host}:9696",
      quantum_admin_tenant_name => $::kickstack::auth_service_tenant,
      quantum_region_name       => $::kickstack::auth_region,
      quantum_admin_username    => $network_auth_username,
      quantum_admin_auth_url    => "http://${auth_host}:35357/v2.0",
      security_group_api        => 'quantum',
    }
  } elsif $::kickstack::network_service == 'neutron' {
    class { '::nova::network::neutron':
      neutron_admin_password    => $network_auth_password,
      neutron_auth_strategy     => 'keystone',
      neutron_url               => "http://${network_host}:9696",
      neutron_admin_tenant_name => $::kickstack::auth_service_tenant,
      neutron_region_name       => $::kickstack::auth_region,
      neutron_admin_username    => $network_auth_username,
      neutron_admin_auth_url    => "http://${auth_host}:35357/v2.0",
      security_group_api        => 'neutron',
    }

  } else {
    fail("Unsupported network type ${::kickstack::network_service}")
  }

}
