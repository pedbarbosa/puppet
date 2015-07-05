class postfix {
  package {
    'postfix':
      ensure => installed;

    [ 'exim4-base',
      'exim4-config',
      'exim4-daemon-light', ]:
      ensure => absent,
      before => Package['postfix'];
  }

  service { 'postfix':
    ensure  => running,
    enable  => true,
    require => Package['postfix'];
  }

  file {
    '/etc/postfix/main.cf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('postfix/main.cf.erb'),
      notify  => Service['postfix'];

    '/etc/postfix/relay_domains':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('postfix/relay_domains.erb'),
      notify  => Service['postfix'];
  }
}
