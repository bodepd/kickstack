#
# kickstack cinder volume class.
#
#
class kickstack::cinder::volume() {

  include ::cinder::config
  include ::cinder::volume

  include "::cinder::volume::${::cinder_backend}"

}
