#
class kickstack::network::agent::l2::network {

  include kickstack::network::config
  include "::${::network_service}::agents::ovs"

}
