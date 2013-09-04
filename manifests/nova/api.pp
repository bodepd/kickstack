#
class kickstack::nova::api{

  include ::nova
  include ::nova::api

  # Stupid hack: Grizzly packages in Ubuntu Cloud Archive
  # require python-eventlet > 0.9, but the python-nova
  # package in UCA does not reflect this
  package { 'python-eventlet':
    ensure => latest
  }


}
