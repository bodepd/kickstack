#
#
class kickstack::rpc() {
  include "kickstack::rpc::${::rpc_type}"
}
