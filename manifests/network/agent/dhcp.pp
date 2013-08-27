#
class kickstack::network::agent::dhcp(
  $network_type = hiera('network_type', 'per-tenant-router'),
  $plugin       = hiera('network_plugin', 'ovs'),
  $debug        = hiera('debug', $::kickstack::debug)
) inherits kickstack {

  include kickstack::network::config

  $interface_driver =  $plugin ? {
    'ovs'         => "${::kickstack::network_service}.agent.linux.interface.OVSInterfaceDriver",
    'linuxbridge' => "${::kickstack::network_service}.agent.linux.interface.BridgeInterfaceDriver",
  }

  $use_namespaces = $network_type ? {
    'per-tenant-router' => true,
    default             => false
  }

  class { "::${::kickstack::network_service}::agents::dhcp":
    debug            => $debug,
    interface_driver => $interface_driver,
    use_namespaces   => $use_namespaces,
  }
}
