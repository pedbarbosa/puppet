class os_default {
  include os_default::ntp

  if $operatingsystem == "Archlinux" {
    include os_default::os_arch
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
