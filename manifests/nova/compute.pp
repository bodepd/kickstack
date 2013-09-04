#
# base class for configuring nova compute nodes
#
class kickstack::nova::compute {

  include ::nova
  include ::nova::compute
  include "::nova::compute::${compute_type}"

}
