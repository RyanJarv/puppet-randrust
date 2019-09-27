# @api private
# @summary This class handles the configuration file.
class randrust::config (
) {
  # If config_epp is defined use that, otherwise use our default template.
  if $randrust::config_epp {
    $config_content = epp($randrust::config_epp)
  } else {
    $config_content = epp('randrust/randrust.epp')
  }

  file { '/etc/default/randrust':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => $config_content,
  }
  # if $randrust::logfile {
  #   file { $randrust::logfile:
  #     ensure => file,
  #     owner  => 'randrust',
  #     group  => 'randrust',
  #     mode   => '0664',
  #   }
  # }
}

