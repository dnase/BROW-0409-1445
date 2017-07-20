class nginx (
  Boolean $highperf = $nginx::params::highperf,
  String $package = $nginx::params::package,
  String $owner = $nginx::params::owner,
  String $group = $nginx::params::group,
  String $docroot = $nginx::params::docroot,
  String $confdir = $nginx::params::confdir,
  String $blockdir = $nginx::params::blockdir,
  String $logdir = $nginx::params::logdir,
  String $service = $nginx::params::service,
  String $user = $nginx::params::user,
) inherits nginx::params {
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
