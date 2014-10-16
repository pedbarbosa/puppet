class os_default {

  if $operatingsystem == "Archlinux" {
    include os_default::arch
  }

  package { [
    'autofs',
    'bash-completion',
    'cifs-utils',
    'curl',
    'dhcpcd',
    'dnsutils',
    'ethtool',
    'git',
    'iftop',
    'iotop',
    'lsof',
    'mlocate',
    'ncdu',
    'net-tools',
    'ntp',
    'openssh',
    'rsync',
    'samba',
    'sysstat',
    'wget',
    'wol',
    ]:
      ensure => latest;
  }

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
