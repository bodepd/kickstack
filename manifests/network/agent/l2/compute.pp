#
class kickstack::network::agent::l2::compute(
  $integration_bridge  = hiera('network_integration_bridge', 'br-int'),
  $tenant_network_type = hiera('tenant_network_type', 'gre'),
  $plugin              = hiera('network_plugin', 'ovs'),
  $tunnel_bridge       = hiera('network_tunnel_bridge', 'br-tun'),
  $physnet             = hiera('network_physnet', false),
  $data_nic            = hiera('data_nic', 'eth3'),
) inherits kickstack {

  include kickstack::network::config

  case $plugin {
    'ovs': {
      case $tenant_network_type {
        'gre': {
          $local_tunnel_ip = get_ip_from_nic($data_nic)
          class { "${::kickstack::network_service}::agents::ovs":
            bridge_mappings    => [],
            bridge_uplinks     => [],
            integration_bridge => $integration_bridge,
            enable_tunneling   => true,
            local_ip           => $local_tunnel_ip,
            tunnel_bridge      => $tunnel_bridge,
          }
        }
        default: {
          if ! $physnet {
            fail('$physnet is expected when tenant network type is not gre')
          }
          $bridge_uplinks = ["br-${data_nic}:${data_nic}"]
          class { "${::kickstack::network_service}::agents::ovs":
            bridge_mappings    => ["${physnet}:br-${data_nic}"],
            bridge_uplinks     => $bridge_uplinks,
            integration_bridge => $integration_bridge,
            enable_tunneling   => false,
            local_ip           => '',
          }
        }
      }
    }
    'linuxbridge': {
      class { "${::kickstack::network_service}::agents::linuxbridge":
        physical_interface_mappings => "default:${data_nic}"
      }
    }
    default: {
      fail("Unsupported plugin ${plugin}")
    }
  }
}
