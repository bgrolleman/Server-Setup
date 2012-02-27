# Really, only configures my .gitconfig
#
# Author: Bas Grolleman <bgrolleman@emendo-it.nl>
#
class gitconfig {
  package { 'git':
    ensure => installed
  }

  file { ['/root/.gitconfig','/home/bgrolleman/.gitconfig']:
    ensure  => 'file',
    content => '[user]
	name = Bas Grolleman
	email = bgrolleman@emendo-it.nl
',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
