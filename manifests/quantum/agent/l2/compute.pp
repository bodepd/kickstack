#
class kickstack::quantum::agent::l2::compute(
) inherits kickstack {

  include kickstack::quantum::config

  $tenant_network_type = "$::kickstack::quantum_tenant_network_type"

  case "$::kickstack::quantum_plugin" {
    'ovs': {
      case $tenant_network_type {
        'gre': {
          $local_tunnel_ip = getvar("ipaddress_${nic_data}")
          class { 'quantum::agents::ovs':
            bridge_mappings    => [],
            bridge_uplinks     => [],
            integration_bridge => $::kickstack::quantum_integration_bridge,
            enable_tunneling   => true,
            local_ip           => $local_tunnel_ip,
            tunnel_bridge      => $::kickstack::quantum_tunnel_bridge,
          }
        }
        default: {
          $bridge_uplinks = ["br-${nic_data}:${nic_data}"]
          class { 'quantum::agents::ovs':
            bridge_mappings    => ["${::kickstack::quantum_physnet}:br-${nic_data}"],
            bridge_uplinks     => $bridge_uplinks,
            integration_bridge => $::kickstack::quantum_integration_bridge,
            enable_tunneling   => false,
            local_ip           => '',
          }
        }
      }
    }
    'linuxbridge': {
      class { "quantum::agents::linuxbridge":
        physical_interface_mappings => "default:$nic_data"
      }
    }
  } 
}
