define scriptura::iac::cassandra(
  $version=undef,
  $versionlock=false
) {
  if ! $version {
    fail('Class[Scriptura::Iac::Cassandra]: parameter version must be provided')
  }

  package { 'scriptura-cassandra':
    ensure => $version
  }

  case $versionlock {
    true: {
      yum::versionlock { "0:scriptura-cassandra-${version}.*":
        require => Package['scriptura-cassandra']
      }
    }
    false: {
      yum::versionlock { "0:scriptura-cassandra-${version}.*":
        ensure  => absent,
        require => Package['scriptura-cassandra']
      }
    }
    default: { fail('Class[Scriptura::Iac::Cassandra::Package]: parameter versionlock must be true or false')}
  }

  service { 'scriptura-cassandra':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['scriptura-cassandra']
  }

}
