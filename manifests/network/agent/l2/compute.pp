#
class kickstack::network::agent::l2::compute {

  include kickstack::network::config
  include "::${::network_service}::agents::ovs"

}
