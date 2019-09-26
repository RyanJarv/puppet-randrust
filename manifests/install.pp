# @summary A short summary of the purpose of this class
#   This class handles the randrust package.
#
# @example
#   include randrust::install
#
class randrust::install {
  if $randrust::package_manage {
    $distro = downcase($facts['os']['name'])

    if ! ($distro in ['debian', 'ubuntu']) {
      fail("${distro} is not supported. Only ubuntu and debian are currently")
    }

    apt::source { 'jarv_test':
      location => "https://packagecloud.io/jarv/test/${distro}/",
      repos    => 'main',
      key      => {
        id     => 'CB3558958B771316670B2C85BD07CDB5921FCE51',
        source => 'https://packagecloud.io/jarv/test/gpgkey',
      },
      include  => { 'deb' => true },
    } -> package { $randrust::package_name:
      ensure  => $randrust::package_ensure,
      require => Exec['apt_update'],
    }

    Apt::Source['jarv_test'] ~> Exec['apt_update']
  }
}

