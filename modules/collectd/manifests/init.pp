class collectd {

  package { [
    'collectd',
    'hddtemp',
    'libhtml-parser-perl',
    'libjson-perl',
    'liboping',
    'librrds-perl',
    'lm_sensors',
    'rrdtool',
    ]:
      ensure => latest;
  }

  service { 'collectd':
    ensure  => running,
    enable  => true,
    require => Package['collectd'];
  }

  file {
    '/etc/collectd.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      source  => 'puppet:///modules/collectd/collectd.conf',
      require => Package['collectd'],
      notify  => Service['collectd'];

    '/etc/collectd.d':
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      source  => 'puppet:///modules/collectd/collectd.d',
      recurse => true,
      require => Package['collectd'],
      notify  => Service['collectd'];
  }
}
