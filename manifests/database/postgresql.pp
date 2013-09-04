#
class kickstack::database::postgresql(
  $root_password  = hiera('database_root_password'),
  $bind_address   = hiera('database_bind_address', '*'),
  $management_nic = hiera('management_nic', $::kickstack::management_nic)
) inherits kickstack{

  include postgresql::server
  include postgresql::config
  #    'ip_mask_deny_postgres_user' => '0.0.0.0/32',
  #    'ip_mask_allow_all_users'    => '0.0.0.0/0',
}
