define scriptura::iac::server::package(
  $version=undef,
  $versionlock=false,
  $type=undef
) {

  package { "scriptura-engage-${type}":
    ensure => $version
  }

  case $type {
    frontend: {
      package { 'existdb': ensure => present }
      service { 'existdb': ensure => running }
    }
    default: {
      info('No additional packages required')
    }
  }

  case $versionlock {
    true: {
      yum::versionlock { "0:scriptura-engage-${type}-${version}.*": }
    }
    false: {
      yum::versionlock { "0:scriptura-engage-${type}-${version}.*": ensure => absent }
    }
    default: { fail('Class[Scriptura::Iac::Server::Package]: parameter versionlock must be true or false')}
  }

}
