class os_default::ntp {
  package { 'ntp': ensure => installed }

  service { 'ntpd':
    ensure  => running,
    enable  => true,
    require => Package['cronie'];
  }

  file { '/etc/localtime':
    ensure  => link,
    target  => '/usr/share/zoneinfo/Australia/Brisbane',
    require => Package['ntpd'],
    notify  => Service['ntpd'];
  }
}
