#
class kickstack::network::agent::l3(
  $network_type       = hiera('network_type', 'per-tenant-router'),
  $plugin             = hiera('network_plugin', 'ovs'),
  $external_bridge    = hiera('network_external_bridge', 'br-ex'),
#  $router_id          = hiera('network_router_id', undef),
#  $gateway_ext_net_id = hiera('network_gw_ext_net_id', undef),
) inherits kickstack {

  include kickstack::network::config

  #vs_bridge { $external_bridge:
  #  ensure => present,
  #}

  $interface_driver = $plugin ? {
    'ovs'         => "${::kickstack::network_service}.agent.linux.interface.OVSInterfaceDriver",
    'linuxbridge' => "${::kickstack::network_service}.agent.linux.interface.BridgeInterfaceDriver"
  }
  $use_namespaces = $network_type ? {
    'per-tenant-router' => true,
    default             => false
  }
  #$router_id = $network_type ? {
  #  'provider-router' => $router_id,
  #  default => undef
  #}
  #$gateway_external_network_id = $network_type ? {
  #  'provider-router' => $gateway_external_network_id,
  #  default           => undef
  #}
  $router_id = undef
  $gateway_external_network_id = undef

  class { "::${::kickstack::network_service}::agents::l3":
    debug                       => $::kickstack::debug,
    interface_driver            => $interface_driver,
    external_network_bridge     => $external_bridge,
    use_namespaces              => $use_namespaces,
    router_id                   => $router_id,
    gateway_external_network_id => $gateway_external_network_id,
    require                     => Class[
      "kickstack::${::kickstack::network_service}::agent::metadata",
      'vswitch::ovs'
    ]
  }
}
