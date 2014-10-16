class os_default::arch { 

  file {
    '/etc/pacman.d/mirrorlist':
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/os_default/arch.mirrorlist';

    '/etc/vimrc':
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/os_default/vimrc';
  }
}
