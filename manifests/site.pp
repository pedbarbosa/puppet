node default {
  include collectd
  include os_default
  include puppet
  include syslog_ng

  if $uniqueid == 'a8c00202' {
    include postfix
    include rtorrent
  }
}
