#!/usr/bin/puppet -v 
#
# Would love to get this working
##
##  puppet -v --modulepath=modules/ setup.pp 
##
include php-fastcgi
include rsnapshot
#
# Puppet Configuration File
# eMendo-IT - Wordpress Web Server

package { [ 'nginx', 'php5', 'php5-cli', 'php5-cgi', 'php5-mysql', 'php5-gd', 'mysql-server', 'mysql-client', 'vim-nox', 'git', 'unzip', 'screen' ]:
	ensure => installed;
}

service { 'apache': 
	ensure => stopped
}
service { 'nginx':
	ensure => running
}

file { '/etc/nginx/sites-enabled/default':
	ensure => absent
}

define wp_site($enable) {
	file { "/etc/nginx/sites-available/${name}":
		mode   => "0644",
		owner  => "root",
		group  => "root",
		replace => false,
		notify => Service['nginx'],
		content => "
server {
	server_name	${name};
	server_name	www.${name};
	root		/var/www/${name};
	include		defaults.phpsite;
}"
	}

	if $enable {
		file { "/etc/nginx/sites-enabled/${name}":
			ensure => "/etc/nginx/sites-available/${name}"
		}
	}
}

file { '/etc/nginx/defaults.phpsite':
	mode  =>  "0644",
	owner => "root",
	group => "root",
	notify => Service['nginx'],
	content => '
index index.php index.html;

## Images and static content is treated different
location ~* ^.+.(jpg|jpeg|gif|css|png|js|ico|xml)$ {
	access_log        off;
	expires           30d;
}

## Disable viewing .htaccess & .htpassword
location ~ /\.ht {
	deny  all;
}

# Redirect All Traffic with no file to Wordpress for pretty URLs
rewrite ^.*/files/(.*)$ /wp-includes/ms-files.php?file=$1 last;
if (!-e $request_filename) {
	rewrite ^.+?(/wp-.*) $1 last;
	rewrite ^.+?(/.*\.php)$ $1 last;
	rewrite ^ /index.php last;
	break;
}
## Parse all .php file in the /var/www directory
location ~ \.php$ {
	include        fastcgi_params;
	fastcgi_pass   127.0.0.1:9001;
	fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
}
'
}

# Setup Default

file { "/etc/nginx/sites-available/default.wordpress":
	mode   => "0644",
	owner  => "root",
	group  => "root",
	notify => Service['nginx'],
	content => "
		server {
			listen 80 default_server;
			server_name _;
			root		/var/www/wordpress;
			include		defaults.phpsite;
		}
	"
}

file { "/etc/nginx/sites-enabled/000-default.wordpress":
	ensure => "/etc/nginx/sites-available/default.wordpress"
}

# Disabled in General Config
#wp_site { "wp1.emendo-it.nl": enable => true}
#wp_site { "rengervanderzande.com": enable => true}
#wp_site { "mkbeemland.nl": enable => false }
