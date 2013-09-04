#
class kickstack::nova::conductor inherits kickstack {

  include ::nova
  include ::nova::conductor

}
