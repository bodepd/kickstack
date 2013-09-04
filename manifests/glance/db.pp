#
class kickstack::glance::db {

  include "::glance::db::${::db_type}"

}
