#
class kickstack::network::db() {

  include "${::network_service}::db::${::db_type}"

}
