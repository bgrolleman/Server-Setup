# Setup checks script to run once every minute, used to monitor with uptime robot
class nagios {
  package { 'nagios-plugins-basic':
    ensure => installed
  }
  file { '/root/checks.sh':
    ensure => 'file',
    source => 'puppet:///modules/nagios/checks.sh',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }
  file { '/etc/cron.d/checksystem':
    ensure  => 'file',
    content => '* * * * * /root/checks.sh > /var/www/<%= fqdn %>/jrVmrLzpoCAr6hYVg.txt',
  }
}

