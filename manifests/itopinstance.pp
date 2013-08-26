#
# define itop::itopinstance
#
define itop::itopinstance (
  $version            = $itop::ensure,
  $docroot            = '/var/www/html',
  $user               = 'apache',
  $group              = 'apache',
  $toolkit            = false,
  $env                = production,
  $source             = undef,
  $ldap_extension     = undef,
  $ldap_host          = undef,
  $ldap_port          = undef,
  $ldap_default_user  = undef,
  $ldap_default_pwd   = undef,
  $ldap_base_dn       = undef,
  $ldap_profile_dn    = undef,
  $ldap_profile_query = undef,
  $extensions         = [],
)
{

  $perm_change = [
    "${docroot}/conf", "${docroot}/data", "${docroot}/env-production",
    "${docroot}/extensions", "${docroot}/log", "${docroot}/env-toolkit"
  ]

  ## iTop installation
  file { "iTop-${version}":
    ensure  => directory,
    path    => $docroot,
    recurse => true,
    source  => "puppet://puppet/itopfs/itop/iTop-${version}/web",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  ## iTop toolkit installation
  if $toolkit {
    file { 'toolkit':
      ensure  => directory,
      path    => "${docroot}/toolkit",
      recurse => true,
      source  => 'puppet://puppet/itopfs/itop/Tools/toolkit',
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
    }
  }

  ## iTop Extensions installation
  itop::itopextensions{ $extensions:
        docroot => $docroot,
        source  => $source,
        user    => $user,
        group   => $group,
        env     => $env,
  }

  ### File permissions on certain directories.
  file { $perm_change:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0750',
    require => File["iTop-${version}"],
  }

  ### Install the ldap configuration script
  file { '/usr/local/bin':
    ensure => directory,
  }

  file { '/usr/local/bin/itop-ldap-config.sh':
    ensure  => file,
    content => template('itop/itop-ldap-config.sh.erb'),
    mode    => '0750',
    require => [
      File['/usr/local/bin'],
      File[$ldap_extension],
    ]
  }

  ### Execute the LDAP configuration script
  exec { "LDAP_Configuration_${name}":
    command   => '/usr/local/bin/itop-ldap-config.sh',
    subscribe => [
      File['/usr/local/bin/itop-ldap-config.sh'],
      File[$ldap_extension],
    ]
  }


}
