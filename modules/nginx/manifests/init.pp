class nginx (
  Optional[String] $root = undef,
  Boolean $highperf = true,
) {
  case $facts['os']['family'] {
    'RedHat', 'Debian': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $default_docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
      $service = 'nginx'
    }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administators'
      $default_docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx/conf'
      $blockdir = 'C:/ProgramData/nginx/conf.d'
      $logdir = 'C:/ProgramData/nginx/logs'
      $service = 'nginx'
    }
  }
  $docroot = $root ? {
    undef   => $default_docroot,
    default => $root,
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
  file { "${docroot}/vhosts":
    ensure => directory,
  }
  file { 'nginx.conf':
    ensure     => file,
    path       => "${confdir}/nginx.conf",
    content    => epp('nginx/nginx.conf.epp', {
      user     => $user,
      confdir  => $confdir,
      blockdir => $blockdir,
      logdir   => $logdir,
      highperf => $highperf,
    }),
    require => Package[$package],
  }
  service { $service:
    ensure    => running,
    enable    => true,
    subscribe => File['nginx.conf'],
  }
  nginx::vhost { 'default':
    docroot     => $docroot,
    server_name => $::fqdn,
  }
}
















