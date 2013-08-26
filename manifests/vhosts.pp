#
# define itop::vhosts
#
define itop::vhosts (
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
  $ldap_user_query    = undef,
  $extensions         = [],
)
{

  $perm_change = [
    "${docroot}/conf", "${docroot}/data", "${docroot}/env-production",
    "${docroot}/extensions", "${docroot}/log"
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
  itop::myextensions{ $extensions:
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

}
