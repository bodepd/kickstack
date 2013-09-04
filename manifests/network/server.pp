#
class kickstack::network::server {

  include kickstack::network::config
  include "${::network_service}::server"

}
