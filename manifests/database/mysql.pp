#
# class that installs a mysql server
#
class kickstack::database::mysql() {


  include mysql::server
  include mysql::config
  include mysql::server::account_security

  #file { '/etc/mysql/conf.d/skip-name-resolve.cnf':
  #  source => 'puppet:///modules/kickstack/mysql/skip-name-resolve.cnf',
  #}

}
