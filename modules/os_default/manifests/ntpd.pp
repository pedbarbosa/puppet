class os_default::ntpd {
  package { 'ntp': ensure => installed }

  service { 'ntpd':
    ensure  => running,
    enable  => true,
    require => Package['ntp'];
  }

  file {
    '/etc/localtime':
      ensure  => link,
      target  => '/usr/share/zoneinfo/Australia/Brisbane',
      require => Package['ntp'],
      notify  => Service['ntpd'];

    '/etc/ntp.conf':
      owner   => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/os_default/ntp.conf',
      notify => Service['ntpd'];
  }
}
