#
# Class itop::vhosts
#
class itop::virtualhosts (
  $version    = itop::ensure,
  $docroot    = '/var/www/html-new',
  $user       = 'apache',
  $group      = 'apache',
  $toolkit    = false,
  $extensions = [],
)
{

  ## iTop installation
  file { "iTop-${version}":
    ensure  => directory,
    path    => $docroot,
    recurse => true,
    source  => "puppet://puppet/itop/itop/iTop-${version}/web",
    owner   => $user,
    group   => $group,
  }
}
