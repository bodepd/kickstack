#
class kickstack::nova::cert inherits kickstack {

  include ::nova
  include ::nova::cert

}
