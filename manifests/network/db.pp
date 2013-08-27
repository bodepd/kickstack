#
class kickstack::network::db(
  $password      = hiera('network_db_password'),
  $user          = hiera('network_db_user', $kickstack::network_service),
  $db_name       = hiera('network_db_name', $kickstack::network_service),
  $host          = hiera('db_host', '127.0.0.1'),
  $allowed_hosts = hiera('db_allowed_hosts', false),
  $type          = hiera('db_type', $::kickstack::db_type)
) inherits kickstack {

  if $type == 'mysql' {

    class { "::${::kickstack::network_service}::db::mysql":
      dbname        => $db_name,
      user          => $user,
      password      => $password,
      charset       => 'utf8',
      allowed_hosts => $allowed_hosts,
    }

  } elsif $type == 'postgresql' {

    class { "::${::kickstack::network_service}::db::postgresql":
      dbname   => $db_name,
      user     => $user,
      password => $password,
    }

  } else {
    fail("Unsupported database type: ${type}")
  }

  # export the password for this database
  data { 'network_db_password':
    value => $password,
  }

}
