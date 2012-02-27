#
# Simple module to configure rsnapshot
#
# Author: Bas Grolleman <bgrolleman@emendo-it.nl>
#
class rsnapshot {
  package { 'rsnapshot':
    ensure => installed
  }
  file { '/etc/rsnapshot.conf':
    ensure  => 'file',
    content => template('rsnapshot/rsnapshot.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  file { '/etc/cron.d/rsnapshot':
    ensure  => 'file',
    source  => 'puppet:///modules/rsnapshot/etc/cron.d/rsnapshot',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

}
