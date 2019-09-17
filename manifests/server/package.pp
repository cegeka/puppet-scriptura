class scriptura::server::package(
  $version=undef,
  $versionlock=false
) {

  package { 'scriptura-engage-server':
    ensure => $version
  }

  case $versionlock {
    true: {
      yum::versionlock { "0:scriptura-engage-server-${version}.*": }
    }
    false: {
      yum::versionlock { "0:scriptura-engage-server-${version}.*": ensure => absent }
    }
    default: { fail('Class[Scriptura::Server::Package]: parameter versionlock must be true or false')}
  }

}
