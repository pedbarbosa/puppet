class os_default {

    package {
        'bash-completion':
            ensure => latest;

        'cifs-utils':
            ensure => latest;

        'sysstat':
            ensure => latest;

        'telnet':
            ensure => latest;

        'wakeonlan':
            ensure => latest;
    }

    file {
        '/etc/ssh/sshd_config':
            ensure => file;

        '/etc/vim/vimrc':
            source => 'puppet:///os_default/vimrc';
    }
}
