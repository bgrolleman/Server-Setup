class php-fastcgi {
	file { '/etc/init.d/php-fastcgi':
		mode => 0755,
		owner => root,
		group => root,
		source => 'puppet://modules/php-fastcgi/php-fastcgi'
	}
}
