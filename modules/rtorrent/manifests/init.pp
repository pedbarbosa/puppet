class rtorrent {
    package {
		'mediainfo':
            ensure => installed;

        'rtorrent':
            ensure => installed;

        'screen':
            ensure => installed;

		'unrar':
            ensure => installed;
    }
}
