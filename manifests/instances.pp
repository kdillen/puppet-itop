#
# Doc
#
class itop::instances (
  $instance_hash = hiera('itop::instance_hash', {}),
  $itop_vhosts_hash = hiera('itop::itop_vhosts_hash', {})
)
{
  Class['itop::install'] -> Class['itop::instances']

  validate_hash($instance_hash)
  if( $instance_hash )
  {
    create_resources( 'itop::instance', $instance_hash )
  }

  validate_hash($itop_vhosts_hash)
  if( $itop_vhosts_hash )
  {
    create_resources( 'itop::vhosts', $itop_vhosts_hash )
  }

}
