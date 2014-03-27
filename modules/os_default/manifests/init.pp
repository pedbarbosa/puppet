class os_default {

    package {
        'bash-completion':
            ensure => installed;
        'cifs-utils':
            ensure => installed;
        'ncdu':
            ensure => installed;
        'sysstat':
            ensure => installed;
        'telnet':
            ensure => installed;
        'wakeonlan':
            ensure => installed;
    }

    file {
        '/etc/ssh/sshd_config':
            ensure => file;

        '/etc/vim/vimrc':
            source => 'puppet:///os_default/vimrc';
    }
}
