# Puppet-Manifests
For puppet files

# Install Docker

Navigate to the manifests i.e. /etc/puppetlabs/code/environments/production/manifests and run:

puppet module install puppetlabs-docker --version 3.8.0

# Insert docker

in your .pp file, add:

include 'docker'

# To change settings

Use the following formats to change the settings, examples:

class { 'docker':

  version => '17.09.0~ce-0~debian',

}

class { 'docker':
  
  docker_ee => true,
  
  docker_ee_source_location => 'https://<docker_ee_repo_url>',
  
  docker_ee_key_source => 'https://<docker_ee_key_source_url>',
  
  docker_ee_key_id => '<key id>',

}
  
class { 'docker':
  
  use_upstream_package_source => false,
  
  repo_opt => '',

}

class { 'docker':
  
  manage_package              => true,
  
  use_upstream_package_source => false,
  
  package_engine_name         => 'docker-engine'
  
  package_source_location     => 'https://get.docker.com/rpm/1.7.0/centos-6/RPMS/x86_64/docker-engine-1.7.0-1.el6.x86_64.rpm',
  
  prerequired_packages        => [ 'glibc.i686', 'glibc.x86_64', 'sqlite.i686', 'sqlite.x86_64', 'device-mapper', 'device-mapper-libs', 'device-mapper-event-libs', 'device-mapper-event' ]

}

# Install images

To install an image, use the following format, examples:

docker::image { 'nextcloud': }

The code above is equivalent to running the docker pull nextcloud command.

docker::image { 'ubuntu':
  
  image_tag => 'precise'

}

# Run containers

To run a container, use the following formats, examples:

docker::run { 'helloworld':
  
  image   => 'base',
  
  command => '/bin/sh -c "while true; do echo hello world; sleep 1; done"',

}

This is equivalent to running the docker run -d base /bin/sh -c "while true; do echo hello world; sleep 1; done" command to launch a Docker container managed by the local init system.

docker::run { 'helloworld':
  
  image            => 'base',
  
  detach           => true,
  
  service_prefix   => 'docker-',
 
  command          => '/bin/sh -c "while true; do echo hello world; sleep 1; done"',
  
  ports            => ['4444', '4555'],
  
  expose           => ['4666', '4777'],
  
  links            => ['mysql:db'],
  
  net              => ['my-user-def-net','my-user-def-net-2'],
  
  disable_network  => false,
  
  volumes          => ['/var/lib/couchdb', '/var/log'],
  
  volumes_from     => '6446ea52fbc9',
  
  memory_limit     => '10m', # (format: '<number><unit>', where unit = b, k, m or g)
  
  cpuset           => ['0', '3'],
  
  username         => 'example',
  
  hostname         => 'example.com',
  
  env              => ['FOO=BAR', 'FOO2=BAR2'],
  
  env_file         => ['/etc/foo', '/etc/bar'],
  
  labels           => ['com.example.foo="true"', 'com.example.bar="false"'],
  
  dns              => ['8.8.8.8', '8.8.4.4'],
  
  restart_service  => true,
  
  privileged       => false,
  
  pull_on_start    => false,
  
  before_stop      => 'echo "So Long, and Thanks for All the Fish"',
  
  before_start     => 'echo "Run this on the host before starting the Docker container"',
  
  after            => [ 'container_b', 'mysql' ],
  
  depends          => [ 'container_a', 'postgres' ],
  
  stop_wait_time   => 0,
  
  read_only        => false,
  
  extra_parameters => [ '--restart=always' ],

}

# Apply Changes

Run: puppet apply your-manifest.pp
