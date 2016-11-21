class logrotate {
    package {
        'logrotate':
            ensure  => installed;
    }

    service {
        'logrotate.timer':
            enable  => true,
            ensure  => running,
            require => Package['logrotate'];
    }

    file {
        '/etc/logrotate.conf':
            owner   => root,
            group   => root,
            mode    => '0644',
            source  => 'puppet:///modules/logrotate/logrotate.conf';

        '/etc/logrotate.d/ntp':
            owner   => root,
            group   => root,
            mode    => '0644',
            source  => 'puppet:///modules/logrotate/logrotate.d/ntp',
            notify  => Service['logrotate.timer'];
    }
}
