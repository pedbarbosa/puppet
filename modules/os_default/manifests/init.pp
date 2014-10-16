class os_default {

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
    'samba',
    'sysstat',
    'wget',
    'wol',
    ]:
      ensure => latest;
  }

  file {
    '/etc/ssh/sshd_config':
      ensure => file;

#   '/etc/vim/vimrc':
#     source => 'puppet:///os_default/vimrc';
  }
}
