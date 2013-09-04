#
class kickstack::nova::db {

  include "::nova::db::${::db_type}"

}
