# init file for iTop Class
class itop (
  $ensure       = undef,
  $install_type = undef,
  $url          = undef,
)
{

#  include stdlib

#  validate_hash($itop_vhosts)
#  if ( $itop_vhosts )
#  {
    #$vhosts = hiera('itop::itop_vhosts')
#    create_resources('itop::resource::vhosts', $itop_vhosts)
#  }

  anchor  { 'itop::start': }->
  class   { 'itop::install':
    ensure       => $ensure,
    install_type => $install_type,
    url          => $url,
  }->
  class   { 'itop::instances': }->
  anchor  { 'itop::end': }

}
