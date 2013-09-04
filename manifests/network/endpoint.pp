#
# This class cannot use the endpoint define b/c it needs to be
# able to select either quantum or neutron as the network service provider
#
class kickstack::network::endpoint {

  include "${::network_service}::keystone::auth"

}
