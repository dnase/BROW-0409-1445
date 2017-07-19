define nginx::vhost (
  $docroot = "${nginx::docroot}/vhosts/${title}",
  $port = '80',
  $server_name = $title,
) {
  File {
    owner => $nginx::owner,
    group => $nginx::group,
    mode  => '0644',
  }
  host { $title:
    ip => $::ipaddress,
  }
  file { $docroot:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure  => file,
    content => epp('nginx/index.html.epp', {server_name => $server_name}),
  }
  file { "nginx-vhost-${title}":
    ensure        => file,
    path          => "${nginx::blockdir}/${title}.conf",
    content       => epp('nginx/vhost.conf.epp', {
      port        => $port,
      docroot     => $docroot,
      server_name => $server_name,
    }),
    notify => Service['nginx'],
  }
}
