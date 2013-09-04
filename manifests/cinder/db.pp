#
# I may not want to use this define b/c it does not expose
# the parameters
#
class kickstack::cinder::db() {

  include "::cinder::db::${::db_type}"

}
