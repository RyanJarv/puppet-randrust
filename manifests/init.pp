# randrust
#
# Main class, includes all other classes.
#
# @param package_name
#   Specifies the randrust package to manage. Default value: ['randrust'].
#
# @param package_manage
#   Whether to manage the randrust package. Default value: true.
#
# @param package_ensure
#   Whether to install the randrust package, and what version to install. Values: 'present', 'latest', or a specific version number.
#   Default value: 'present'.
#
# @param config_epp
#   Specifies an absolute or relative file path to an EPP template for the config file. Example value: 'randrust/randrust.epp'.
#
# @param listen_port
#   Specifies the listen port for randrust to serve traffic from
#
# @param interface
#   Specifies the interface to listen on. Default: '0.0.0.0'.
#
# @param package_ensure
#   Whether to install the randrust package, and what version to install. Values: 'present', 'latest', or a specific version number.
#   Default value: 'present'.
#
# @param service_manage
#   Whether to manage the randrust service.  Default value: true.
#
# @param service_enable
#   Whether to enable the randrust service at boot. Default value: true.
#
# @param service_ensure
#   Whether the randrust service should be running. Default value: 'running'.
#
# @param service_provider
#   Which service provider to use for randrust. Default value: 'undef'.
#
# @param service_name
#   The name of the randrust service to manage.
#
class randrust (
  String $package_ensure,
  Boolean $package_manage,
  Array[String] $package_name,
  Optional[String] $config_epp,
  Optional[String] $interface,
  Optional[Integer[0, 65535]] $listen_port,
  Boolean $service_manage,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  Optional[String] $service_provider,
  String $service_name,
) {
  contain randrust::install
  contain randrust::config
  contain randrust::service


  Class['::randrust::install']
  -> Class['::randrust::config']
  ~> Class['::randrust::service']
}

