#
# Sets up a nova controller
#
class kickstack::nova::controller {

  include kickstack::nova::config
  include kickstack::nova::api
  include kickstack::nova::scheduler
  include kickstack::nova::objectstore
  include kickstack::nova::cert
  include kickstack::nova::consoleauth
  include kickstack::nova::conductor
  include kickstack::nova::networkclient
  include kickstack::nova::vncproxy

}
