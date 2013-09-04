#
#
# TODO - I have no idea what to do here
#
# class used to configured databases
#
class kickstack::database::databases() {
  if member($::enabled_services, 'cinder') {
    include kickstack::cinder::db
  }
  if member($::enabled_services, 'glance') {
    include kickstack::glance::db
  }
  if member($::enabled_services, 'keystone') {
    include kickstack::keystone::db
  }
  if member($::enabled_services, 'nova') {
    include kickstack::nova::db
  }
  if member($::enabled_services, 'swift') {
    include kickstack::swift::db
  }
  if member($::enabled_services, 'network') {
    include kickstack::network::db
  }

}
