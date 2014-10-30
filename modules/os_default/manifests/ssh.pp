class os_default::ssh {
  package { 'openssh': ensure => installed }

  service { 'sshd':
    ensure  => running,
    enable  => true,
    require => Package['openssh'];
  }

  file {
    '/etc/ssh/sshd_config':
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/os_default/sshd_config',
      notify => Service['sshd'];
  }
}
