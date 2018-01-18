# Define: scriptura::server::config::alias
#
# You need to specify the alias title as the name of the XML tag element
# e.g. alias0, alias1, ...
#
# Sample Usage:
#
# scriptura::server::config::alias { 'alias0':
#   version      => '7.3.24-1.cgk.el6',
#   type         => 'jms-session',
#   name         => 'Sonic'
# }
#
define scriptura::server::config::alias(
  $version = undef,
  $type = undef,
  $alias_name = undef
) {

  if ($type == undef or $alias_name == undef) {
    fail("Scriptura::Server::Config::Alias[${title}]: parameters version, type and alias_name must be defined")
  }

  $scriptura_version_withoutrelease = regsubst($version, '^(\d+\.\d+\.\d+)-\d+\..*$', '\1')
  $scriptura_major_minor_version = regsubst($scriptura_version_withoutrelease, '^(\d+\.\d+).\d+$', '\1')
  $scriptura_config_location = "/data/scriptura/scriptura-${scriptura_major_minor_version}/configuration"

  augeas { "scriptura/configuration/aliases/${title}/add" :
    lens    => 'Xml.lns',
    incl    => "${scriptura_config_location}/configuration.xml",
    context => "/files/${scriptura_config_location}/configuration.xml",
    changes => [
      "set config/aliases/${title}/alias-name/#text ${alias_name}",
      "set config/aliases/${title}/alias-type/#text ${type}"
    ],
    onlyif  => "match config/aliases/${title}/alias-name/#text[. = \"${alias_name}\"] size == 0"
  }

}
