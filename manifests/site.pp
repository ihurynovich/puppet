node "vm4" {
  include ntp
  include mysql::server

   mysql::db { 'test_mdb_2':
      user     => 'test_user',
      password => 'test',
      host     => 'localhost',
      grant    => ['ALL'],
  }
}
