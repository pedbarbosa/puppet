class syslog_ng {
    package {
        'rsyslog':
            ensure  => absent;
        'syslog-ng':
            ensure  => installed;
    }

    service {
        'syslog-ng@default':
            enable  => true,
            ensure  => running,
            require => Package['syslog-ng'];
    }

    file {
        '/etc/syslog-ng/syslog-ng.conf':
            owner   => root,
            group   => root,
            mode    => '0644',
            source  => 'puppet:///modules/syslog_ng/syslog-ng.conf',
            require => Package['syslog-ng'],
            notify  => Service['syslog-ng@default'];

        '/etc/logrotate.d/syslog-ng':
            owner   => root,
            group   => root,
            mode    => '0644',
            source  => 'puppet:///modules/syslog_ng/syslog-ng.logrotate',
            require => Package['logrotate'],
            notify  => Service['logrotate.timer'];
    }
}
