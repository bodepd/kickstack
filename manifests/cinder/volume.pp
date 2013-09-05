#
# kickstack cinder volume class.
#
#
class kickstack::cinder::volume() {

  include ::cinder
  include ::cinder::volume
  include ::cinder::setup_test_volume

  include "::cinder::volume::${::cinder_backend}"

}
