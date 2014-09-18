node "vm4" {
  include mysql::server

   mysql::db { 'prod_mdb':
      user     => 'prod_user',
      password => 'test',
      host     => 'localhost',
      grant    => ['ALL'],
  }
}

node "vm6" {
  include nginx
}
