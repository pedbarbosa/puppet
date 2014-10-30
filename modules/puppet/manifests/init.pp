# == Class: puppet
#
# Configures puppet for both the puppetmaster and its minions
#
class puppet {

  package { [
    'facter',
    'hiera',
    'puppet',
  ]:
    ensure => installed;
  }

  service { 'puppet':
    ensure  => running,
    enable  => true,
    require => Package['puppet'];
  }

  if $uniqueid == 'a8c00202' {
    service {
      'puppetmaster':
        ensure => running,
        enable => true,
        require => Package['puppet'];
    }
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
