class kickstack::database {
  include "kickstack::database::${::db_type}"
}
