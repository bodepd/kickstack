#
class kickstack::network::agent::l3 {

  include kickstack::network::config
  include "::${::network_service}::agents::l3"

}
