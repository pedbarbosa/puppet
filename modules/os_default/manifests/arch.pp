class os_default::arch {

  package { [
    'openssh',
    'wol',
    ]:
      ensure => installed;
  }

  service {
    'sshd':
      ensure  => running,
      enable  => true,
      require => Package['openssh'];
  }      

  file {
    '/etc/pacman.d/mirrorlist':
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/os_default/arch.mirrorlist';

    '/etc/ssh/sshd_config':
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/os_default/sshd_config',
      notify => Service['sshd'];

    '/etc/vimrc':
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/os_default/vimrc';
  }
}