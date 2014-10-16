class os_default::arch { 

  file {
    '/etc/pacman.d/mirrorlist':
      source => 'puppet:///modules/os_default/arch.mirrorlist';

    '/etc/vimrc':
      source => 'puppet:///modules/os_default/vimrc';
  }
}
