#
class kickstack::network::config(
  $rpc_host     = hiera('rpc_host', '127.0.0.1'),
  $rpc_user     = hiera('rpc_user', 'openstack'),
  $rpc_type     = hiera('rpc_type', $::kickstack::rpc_type),
  $rpc_password = hiera('rpc_password'),
  $network_type = hiera('network_type', 'per-tenant-router'),
  $plugin       = hiera('network_plugin', 'ovs'),
  $verbose      = hiera('verbose', $::kickstack::verbose),
  $debug        = hiera('debug', $::kickstack::debug),
) inherits kickstack {

  $allow_overlapping_ips = $network_type ? {
    'single-flat'       => false,
    'provider-router'   => false,
    'per-tenant-router' => true,
  }

  $cap_network_service = capitalize($::kickstack::network_service)

  $core_plugin = $plugin ? {
    'ovs' => "${::kickstack::network_service}.plugins.openvswitch.ovs_${::kickstack::network_service}_plugin.OVS${$cap_network_service}PluginV2",
    'linuxbridge' => "${::kickstack::network_service}.plugins.linuxbridge.lb_${::kickstack::network_service}_plugin.LinuxBridgePluginV2"
  }

  case $rpc_type {
    'rabbitmq': {
      class { $::kickstack::network_service:
        rpc_backend           => "${::kickstack::network_service}.openstack.common.rpc.impl_kombu",
        rabbit_host           => $rpc_host,
        rabbit_user           => $rpc_user,
        rabbit_password       => $rpc_password,
        verbose               => $verbose,
        debug                 => $debug,
        allow_overlapping_ips => $allow_overlapping_ips,
        core_plugin           => $core_plugin,
      }
    }
    'qpid': {
      class { $::kickstack::network_service:
        rpc_backend           => "${::kickstack::network_service}.openstack.common.rpc.impl_qpid",
        qpid_hostname         => $rpc_host,
        qpid_username         => $rpc_user,
        qpid_password         => $rpc_password,
        verbose               => $verbose,
        debug                 => $debug,
        allow_overlapping_ips => $allow_overlapping_ips,
        core_plugin           => $core_plugin,
      }
    }
    default: {
      fail("Unsupported rpc_type: ${rpc_type}")
    }
  }
}
