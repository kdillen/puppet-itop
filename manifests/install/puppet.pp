#
# Class itop::install
#
class itop::install::puppet (
  $ensure           = undef,
  $url              = undef,
  $php_version      = '',
)
{
  case $::operatingsystem {
    centos, redhat: {
      # EPEL required for 'php-mcrypt', 'php-domxml-php4-php5'
      $php_packages = [
        'php-mysql', 'php-soap',
        'php-ldap', 'php-domxml-php4-php5',
      ]
      # Not available on EPEL EL 5
      #package{ [ "php-mcrypt" ]:
      #  ensure => installed,
      #}
    }
    gentoo: {
      $php_packages = php
    }
    default: { fail('Unrecognized OS for iTop FS configuration') }
    # "fail" is a function. We'll get to those later.
  }

  package{ $php_packages:
    ensure => installed,
  }

}
