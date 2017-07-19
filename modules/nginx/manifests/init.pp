class nginx {
  case $facts['os']['family'] {
    'RedHat', 'Debian': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
      $service = 'nginx'
    }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx/conf'
      $blockdir = 'C:/ProgramData/nginx/conf.d'
      $logdir = 'C:/ProgramData/nginx/logs'
      $service = 'nginx'
    }
  }
  $user = $facts['os']['family'] ? {
    'windows' => 'nobody',
    'Debian'  => 'www-data',
    default   => 'nginx',
  }
  File {
    owner => $owner,
    group => $group,
    mode  => '0644',
  }
  package { $package:
    ensure => latest,
  }
  file { 'docroot':
    ensure => directory,
    path   => $docroot,
  }
  file { 'index.html':
    ensure => file,
    path   => "${docroot}/index.html",
    source => 'puppet:///modules/nginx/index.html',
  }
  file { 'nginx.conf':
    ensure  => file,
    path    => "${confdir}/nginx.conf",
    source  => "puppet:///modules/nginx/${::osfamily}.conf",
    require => Package[$package],
  }
  service { $service:
    ensure    => running,
    enable    => true,
    subscribe => File['nginx.conf'],
  }
}
















