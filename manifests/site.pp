node default {
  include postfix
  include puppet
  include rtorrent
  include syslog_ng

  package {
    'bash':
      ensure => installed;
  }
}
