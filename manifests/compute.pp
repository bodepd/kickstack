#
# models a reasonable deployment of a compute host.
# I am not happy with how complicated this is.
#
# I am considering dropping support for nova-networks
#
#
class kickstack::compute(
  $volume_on_compute = hiera('volume_on_compute', true),
) inherits kickstack {

  include kickstack::nova::config
  include kickstack::nova::compute

  # should this not be in the nova::compute class
  include kickstack::network::config
  include kickstack::nova::networkclient
  include kickstack::network::agent::l2::compute

  if $volume_on_compute {
    include kickstack::cinder::volume
    # TODO - don't have this here...
    # set in nova::api
    if ! defined(Nova_config['DEFAULT/volume_api_class']) {
      nova_config { 'DEFAULT/volume_api_class': value => 'nova.volume.cinder.API' }
    }
  }
}
