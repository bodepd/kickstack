
#
# TODO - I have no idea what to do here
#
# class used to configured databases
#
class kickstack::database::databases() {
  if member($::enabled_services, 'cinder') {
    include "::cinder::db::${::db_type}"
  }
  if member($::enabled_services, 'glance') {
    include "::glance::db::${::db_type}"
  }
  if member($::enabled_services, 'keystone') {
    include "::keystone::db::${::db_type}"
  }
  if member($::enabled_services, 'nova') {
    include "::nova::db::${::db_type}"
  }
  if member($::enabled_services, 'network') {
    include "::${network_service}::db::${::db_type}"
  }

}
