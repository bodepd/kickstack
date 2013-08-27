#
class kickstack::network::client inherits kickstack {

  kickstack::client { $::kickstack::network_service: }

}
