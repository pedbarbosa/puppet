class os_default::cronie {
  package { 'cronie': ensure => installed }

  service { 'cronie':
    ensure  => running,
    enable  => true,
    require => Package['cronie'];
  }
}
