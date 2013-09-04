#
class kickstack::network::agent::l2::network(
  $external_nic        = hiera('external_nic'),
  $physnet             = hiera('network_physnet', 'default'),
  $integration_bridge  = hiera('intergration_bridge', 'br-int'),
  $external_bridge     = hiera('network_external_bridge', 'br-ex'),
  $tunnel_bridge       = hiera('network_tunnel_bridge', 'br-tun'),
) inherits kickstack {

  include kickstack::network::config
  include "::${::network_service}::agents::ovs"

}
