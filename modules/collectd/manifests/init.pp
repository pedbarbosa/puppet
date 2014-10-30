class collectd {

  service { 'collectd':
    ensure  => running,
    enable  => true,
    require => Package['collectd'];
  }

  if $operatingsystem == "Archlinux" {
    package { [
      'collectd',
      'hddtemp',
      'liboping',
      'lm_sensors',
      'rrdtool',
      ]:
        ensure => installed;
    }

    file {
      '/etc/collectd.conf':
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        content => template('collectd/collectd.conf.erb'),
        require => Package['collectd'],
        notify  => Service['collectd'];

     '/etc/collectd.d':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        source  => 'puppet:///modules/collectd/arch',
        recurse => true,
        require => Package['collectd'],
        notify  => Service['collectd'];
    }
  } elsif $operatingsystem == "Debian" {
    package { [
      'collectd',
      'lm-sensors',
      ]:
        ensure => installed;
    }

    file {
      '/etc/collectd/collectd.conf':
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        content => template('collectd/collectd.conf.erb'),
        require => Package['collectd'],
        notify  => Service['collectd'];

      '/etc/collectd/collectd.d':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        source  => 'puppet:///modules/collectd/debian',
        recurse => true,
        require => Package['collectd'],
        notify  => Service['collectd'];
    }
  }
}
