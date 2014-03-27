node 'morango.home.gateway' {
    include os_default
    include postfix
    include rtorrent
    include syslog-ng
}
