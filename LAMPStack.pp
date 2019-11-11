#Make sure to save this file in /etc/puppetlabs/code/environments/production/manifests

exec { 'apt-update':
  command => '/usr/bin/apt-get update'
}

package { 'apache2':
  require => Exec['apt-update'],
  ensure => installed,
}

service { 'apache2':
  ensure => running,
}

package { 'mysql-server':
  require => Exec['apt-update'],
  ensure => installed,
}

service { 'mysql':
  ensure => running,
}

package { 'php7.0':
  require => Exec['apt-update'],
  ensure => installed,
}

file { '/var/www/html/phpinfo.php':
  ensure => file,
  content => '<?php phpinfo();  ?>',
  require => Package['apache2'],
}
