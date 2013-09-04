# kickstack::keystone::endpoints
#
# Configures endpoints
#
class kickstack::keystone::endpoints {

  if member($::enabled_services, 'cinder') {
    include kickstack::cinder::endpoint
  }
  if member($::enabled_services, 'glance') {
    include kickstack::glance::endpoint
  }
  if member($::enabled_services, 'keystone') {
    include kickstack::keystone::endpoint
  }
  if member($::enabled_services, 'nova') {
    include kickstack::nova::endpoint
  }
  if member($::enabled_services, 'swift') {
    include kickstack::swift::endpoint
  }
  if member($::enabled_services, 'network') {
    include kickstack::network::endpoint
  }

}
