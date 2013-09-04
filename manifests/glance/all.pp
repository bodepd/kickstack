#
# installs a fully functional glance node
#
class kickstack::glance::all() {

  include kickstack::glance::api
  include kickstack::glance::config
  include "kickstack::glance::backend::${::glance_backend}"
  include kickstack::glance::registry

}
