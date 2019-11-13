node 'default'{
file {'/tmp/testing':
  ensure => present,
}
}

node 'puppetagent2'{
include 'docker'

docker::image { 'nextcloud':
  ensure => 'present',
}

docker::run { 'nextcloud':
  image => 'nextcloud',
  ports => ['8080:80'],
}
}

node 'puppetagent1'{
include 'docker'

docker::image { 'tomcat':
  ensure => 'present',
}

docker::run { 'tomcat':
  image => 'tomcat',
}
}
