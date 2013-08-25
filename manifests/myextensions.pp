#
#
#
define itop::myextensions()
{

  $docroot = $itop::vhosts::docroot
  $source = $itop::sourcedir
  $user = $itop::vhosts::user
  $group = $itop::vhosts::group
  $env = $itop::vhosts::env

  file { $name:
    ensure  => directory,
    path    => "${docroot}/extensions/${name}",
    recurse => true,
    source  => "puppet://puppet/itopfs/${env}/${source}/${name}",
    mode    => '0644',
    owner   => $user,
    group   => $group,
  }
}
