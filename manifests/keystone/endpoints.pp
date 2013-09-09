# kickstack::keystone::endpoints
#
# Configures endpoints
#
class kickstack::keystone::endpoints {

  if member($::enabled_services, 'cinder') {
    include cinder::keystone::auth
  }
  if member($::enabled_services, 'glance') {
    include ::glance::keystone::auth
  }
  if member($::enabled_services, 'keystone') {
    include ::keystone::endpoint
    include ::keystone::roles::admin
  }
  if member($::enabled_services, 'nova') {
    include ::nova::keystone::auth
  }
  if member($::enabled_services, 'swift') {
    include ::swift::keystone::auth
  }
  if member($::enabled_services, 'network') {
    include "::${::network_service}::keystone::auth"
  }

}
