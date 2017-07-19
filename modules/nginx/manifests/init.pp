class nginx {
  package { 'nginx':
    ensure => latest,
  }
  file { 'docroot':
    ensure => directory,
    path   => '/var/www',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file { 'index.html':
    ensure => file,
    path   => '/var/www/index.html',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nginx/index.html',
  }
  file { 'nginx.conf':
    ensure  => file,
    path    => '/etc/nginx/nginx.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['nginx.conf'],
  }
}
















