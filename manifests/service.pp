# @summary
#   This class handles the randrust service.
#
# @example
#   include randrust::service
#
class randrust::service (
) {

  if ! ($randrust::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $randrust::service_manage == true {
    service { 'randrust':
      ensure     => $randrust::service_ensure,
      enable     => $randrust::service_enable,
      name       => $randrust::service_name,
      provider   => $randrust::service_provider,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}

