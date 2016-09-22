class lamp {

  if $operatingsystem == "Archlinux" {
    package { 'apache':
      ensure => installed;
    }

    service { 'httpd':
      ensure  => running,
      enable  => true,
      require => Package['apache'];
    }

    file { '/etc/httpd/conf/httpd.conf':
      owner   => 'root',
      group   => 'root',
      source  => 'puppet:///modules/lamp/httpd.conf',
      require => Package['apache'],
      notify  => Service['httpd'];
    }
  }

}
