class os_default {
	
	package {
		'bash-completion':
			ensure => latest;

		'cifs-utils':
			ensure => latest;

		'telnet':
			ensure => latest;
	}

    file {
		#'/etc/localtime':
			#ensure => link,
	 		#target => '/usr/share/zoneinfo/Australia/Brisbane';

        '/etc/ssh/sshd_config':
            ensure => file;

        '/etc/vim/vimrc':
            source => 'puppet:///os_default/vimrc';
    }
}
