#
class kickstack::keystone::db {

  include "::keystone::db::${::db_type}"

}
