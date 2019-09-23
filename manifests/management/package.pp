class scriptura::management::package(
  $version=undef,
  $versionlock=false
) {

  package { 'scriptura-engage-management':
    ensure => $version
  }

  case $versionlock {
    true: {
      yum::versionlock { "0:scriptura-engage-management-${version}.*": }
    }
    false: {
      yum::versionlock { "0:scriptura-engage-management-${version}.*": ensure => absent }
    }
    default: { fail('Class[Scriptura::Management::Package]: parameter versionlock must be true or false')}
  }

}
