#
class kickstack::network::agent::metadata(
  $shared_secret    = hiera('metadata_shared_secret'),
  $service_user     = hiera('network_service_user', $::kickstack::network_service),
  $service_password = hiera('network_service_password'),
  $metadata_ip      = hiera('nova_metadata_ip'),
  $auth_host        = hiera('auth_internal_address', '127.0.0.1'),
  $debug            = hiera('debug', $::kickstack::debug),
  $service_tenant   = hiera('service_tenant', 'services'),
) inherits kickstack {

  include kickstack::network::config

  class { "::${::kickstack::network_service}::agents::metadata":
    shared_secret     => $shared_secret,
    auth_password     => $service_password,
    debug             => $debug,
    auth_tenant       => $service_tenant,
    auth_user         => $service_user,
    auth_url          => "http://${auth_host}:35357/v2.0",
    auth_region       => $::kickstack::auth_region,
    metadata_ip       => $metadata_ip,
  }

}
