#
class kickstack::keystone::api {

  include ::keystone
  include ::keystone::roles::admin

}
