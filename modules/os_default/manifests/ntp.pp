class os_default::ntp {
  package { 'ntp': ensure => installed }

  service { 'ntp':
    ensure  => running,
    enable  => true,
    require => Package['ntp'];
  }

  file { '/etc/localtime':
    ensure  => link,
    target  => '/usr/share/zoneinfo/Australia/Brisbane',
    require => Package['ntp'],
    notify  => Service['ntp'];
  }
}
