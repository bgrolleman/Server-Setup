#
# Usage: puppet apply --modulepath=`pwd`/modules" -v <file>.pp 
# Author: Bas Grolleman <bgrolleman@emendo-it.nl>
#
include php-fastcgi
include rsnapshot
include gitconfig
include nagios
include nginx
#
# eMendo-IT - Base packages that do not get configure/don't have module
package { [ 'mysql-server', 'mysql-client', 'vim-nox', 'unzip', 'screen' ]:
	ensure => installed;
}

# Setup Example
#wp_site { "NAME", enable => true }
wp_site { "rengervanderzande.com": enable => true}
