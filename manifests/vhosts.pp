#
# define itop::vhosts
#
define itop::vhosts (
  $version    = $itop::ensure,
  $docroot    = '/var/www/html-new',
  $user       = 'apache',
  $group      = 'apache',
  $toolkit    = false,
  $env        = production,
  $extensions = [],
)
{

  ### Local variables
  $source = $itop::sourcedir

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
  itop::myextensions{ $extensions: }

  ### File permissions on certain directories.
  file { $perm_change:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0750',
    require => File["iTop-${version}"],
  }

}
