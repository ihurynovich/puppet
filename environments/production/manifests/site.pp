node "vm4" {
  #include nginx
  include mysql::server
  #include zip
  #include java

  #class { 'jboss':
  #  install             => 'source',
  #  version             => '7',
  #}  

  exec { "download":
    command => "curl -s -S   -o /tmp/guestbookapp.zip http://www.cumulogic.com/download/Apps/guestbookapp.zip",
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }

  exec { "unzip":
    command => 'unzip /tmp/guestbookapp.zip -d /opt/jboss/standalone/deployments',
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }

  mysql::db { "guestbook":
    user     => 'demo',
    password => 'demodemo',
    host     => 'localhost',
    grant    => ['ALL'],
    sql      =>  '/opt/jboss/standalone/deployments/guestbookapp/guestbookmysqldump.sql',
    #require  => File["/opt/jboss/standalone/deployments/guestbookapp/guestbookmysqldump.sql"],
  }

class { 'nginx': }
  nginx::resource::vhost { 'puppet':
    proxy => 'http://localhost:8080/',
  }
}
