node default {
  include collectd
  include os_default
  include postfix
  include puppet
  include rtorrent
  include syslog_ng
}
