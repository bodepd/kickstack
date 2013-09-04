#
class kickstack::cinder::controller {
  include ::cinder
  include ::cinder::api
  include ::cinder::scheduler
}

