# == Class: puppet
#
# Configures puppet for both the puppetmaster and its minions
#
class puppet {

  package {
    'facter':
      ensure => '2.4.0-1';
    'hiera':
      ensure => '1.3.4-2';
    'puppet':
      ensure => '3.7.4-2';
  }

  service { 'puppet':
    ensure  => running,
    enable  => true,
    require => Package['puppet'];
  }

  file {
    '/etc/puppet/puppet.conf':
      ensure  => present,
      content => template('puppet/puppet.conf.erb'),
      owner   => 'puppet',
      group   => 'puppet',
      mode    => '0644',
      notify  => Service['puppet'];

    '/usr/local/bin/cdiff':
      ensure => present,
      source => 'puppet:///modules/puppet/cdiff',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      before => File['/etc/puppet/puppet.conf'];
  }
}
