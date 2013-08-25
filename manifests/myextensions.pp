#
#
#
define itop::myextensions(
  $docroot = undef,
  $source = undef,
  $user = undef,
  $group = undev,
  $env = undev,
)
{

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
