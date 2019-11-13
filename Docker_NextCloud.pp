include 'docker'

docker::image { 'nextcloud':
  ensure => 'present',
}

docker::run { 'nextcloud':
  image => 'nextcloud',
  ports => ['8080:80'],
}
