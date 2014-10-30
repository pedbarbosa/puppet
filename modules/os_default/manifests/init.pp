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
    'rsync',
    'ruby',
    'samba',
    'sysstat',
    'wget',
    ]:
      ensure => installed;
  }

  package {
    'msgpack':
      ensure   => installed,
      provider => 'gem',
      require  => Package['ruby'];
  }
}