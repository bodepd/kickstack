#
# This roles includes everythign needed to set
# up a controller for quantum
#
# This is obviously doing way too much atm
#
#
class kickstack::network_controller inherits kickstack {

  include kickstack::network::config
  include kickstack::network::plugin
  include kickstack::network::server
  include kickstack::network::agent::metadata
  include kickstack::network::agent::l3
  include kickstack::network::agent::dhcp
  include kickstack::network::agent::l2::network

}
