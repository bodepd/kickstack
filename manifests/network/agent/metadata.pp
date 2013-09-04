#
class kickstack::network::agent::metadata {

  include kickstack::network::config
  include "::${::network_service}::agents::metadata"

}
