#
# base class for configuring nova compute nodes
#
class kickstack::nova::compute {

  include ::nova
  include ::nova::compute
  inculde "::nova::compute::${compute_type}"

}
