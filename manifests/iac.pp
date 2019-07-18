# Class: scriptura::iac
#
# This module manages scriptura
#
# Parameters:
#
# Actions:
#
# Requires:
# Hiera data:
#   scriptura::iac::data_dir:
#     '/data/scriptura':
#       ensure: 'directory'
#       owner:  'scriptura'
#       group:  'scriptura'#       
#
# Sample Usage:
#
class scriptura::iac {

  $data_dir = lookup({ 'name' =>'scriptura::iac::data_dir', 'default_value' => {} , merge => hash })

  create_resources(file,$data_dir)

}
