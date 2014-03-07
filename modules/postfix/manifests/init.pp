class postfix {
    package {
	    'postfix':
		    ensure => installed;
		'exim4-base':
			ensure => absent,
			before => Package['postfix'];
		'exim4-config':
			ensure => absent,
			before => Package['postfix'];
		'exim4-daemon-light':
			ensure => absent,
			before => Package['postfix'];
	}
}
