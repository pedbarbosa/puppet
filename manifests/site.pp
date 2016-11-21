node default {
  include os_default

  include collectd
  include puppet
  include logrotate
  include syslog_ng

  if $uniqueid == 'a8c00202' {
    include postfix
  }
}
