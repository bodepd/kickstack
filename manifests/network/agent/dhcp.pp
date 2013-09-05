#
class kickstack::network::agent::dhcp {

  include kickstack::network::config
  include "::${::network_service}::agents::dhcp"

}
