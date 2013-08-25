#
# Doc
#
class itop::instances (
  $instance_hash = hiera('itop::instance_hash', {}),
  $vhosts_hash = hiera('itop::vhosts_hash', {})
)
{
  Class['itop::install'] -> Class['itop::instances']

  validate_hash($instance_hash)
  if( $instance_hash )
  {
    create_resources( 'itop::instance', $instance_hash )
  }

  validate_hash($vhosts_hash)
  if( $vhosts_hash )
  {
    #create_resources( 'itop::virtualhosts', $vhosts_hash )
  }

}
