class profile::wordpress {
  wordpress_app::simple { 'capstone':
    nodes                           => {
      Node['drewbilee.puppetlabs.vm'] => [
        Wordpress_app::Database['capstone'],
        Wordpress_app::Web['capstone'],
      ]
    }
  }
}
