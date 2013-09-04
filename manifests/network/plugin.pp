#
class kickstack::network::plugin{

  include kickstack::network::config

  include "${::network_service}::plugins::ovs"

}
