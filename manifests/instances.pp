#
# Doc
#
class itop::instances (
  $instance_hash = hiera('itop::instance_hash', {}),
  $itop_instance_hash = hiera('itop::itop_instance_hash', {})
)
{
  Class['itop::install'] -> Class['itop::instances']

  validate_hash($instance_hash)
  if( $instance_hash )
  {
    create_resources( 'itop::instance', $instance_hash )
  }

  validate_hash($itop_instance_hash)
  if( $itop_instance_hash )
  {
    create_resources( 'itop::itopinstance', $itop_instance_hash )
  }

}
