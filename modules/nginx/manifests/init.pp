# Setup NGINX with PHP5 for me
#
#
class nginx {
  package { [ 'nginx', 'php5', 'php5-cli', 'php5-cgi', 'php5-mysql', 'php5-gd' ]:
    ensure => installed
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
  file { '/etc/nginx/defaults.phpsite':
    mode  =>  "0644",
    owner => "root",
    group => "root",
    notify => Service['nginx'],
    source => 'puppet:///modules/nginx/defaults.phpsite',
  }

  file { "/etc/nginx/sites-available/default.wordpress":
    ensure => 'file',
    mode   => "0644",
    owner  => "root",
    group  => "root",
    notify => Service['nginx'],
    source => 'puppet:///modules/nginx/default.wordpress',
  }
  file { "/etc/nginx/sites-enabled/000-default.wordpress":
    ensure => 'link',
    target => "/etc/nginx/sites-available/default.wordpress"
  }
}

define wp_site($enable) {
  file { "/etc/nginx/sites-available/${name}":
    mode   => "0644",
    owner  => "root",
    group  => "root",
    replace => false,
    notify => Service['nginx'],
    content => template('nginx/wp_site.erb'),
  }

  if $enable {
    file { "/etc/nginx/sites-enabled/${name}":
      ensure => "/etc/nginx/sites-available/${name}"
    }
  }
}
