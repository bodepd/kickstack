#
class kickstack::nova::networkclient {

  include ::nova
  include "::nova::network::${::network_service}"

}
