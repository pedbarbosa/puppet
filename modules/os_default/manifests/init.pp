class os_default {

  if $operatingsystem == "Archlinux" {
    include os_default::ntpd
    include os_default::os_arch

    #package {
    #  'msgpack':
    #    ensure   => installed,
    #    provider => 'gem',
    #    require  => Package['ruby'];
    #}
  } else {
    include os_default::ntp
  }

  package { [
    'autofs',
    'bash-completion',
    'bind-tools',
    'cifs-utils',
    'curl',
    'dhcpcd',
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
}
