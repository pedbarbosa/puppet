class os_default::os_arch {
  include os_default::cronie
  include os_default::ssh

  package { [
    'dos2unix',
    'wol',
    ]:
      ensure => installed;
  }

  file {
    '/etc/pacman.d/mirrorlist':
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/os_default/arch.mirrorlist';

#    '/etc/vimrc':
#      owner  => 'root',
#      group  => 'root',
#      mode   => '0644',
#      source => 'puppet:///modules/os_default/vimrc';
  }
}
