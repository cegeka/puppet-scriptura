class scriptura::iac::management::backenddb (
  $ensure = present,
) {

  class { 'postgresql::server': }

  $database = lookup({ 'name' =>'scriptura::iac::management::backenddb::database', 'default_value' => {} , merge => hash })
  $database_grant = lookup({ 'name' =>'scriptura::iac::management::backenddb::database_grant', 'default_value' => {} , merge => hash })
  $role = lookup({ 'name' =>'scriptura::iac::management::backenddb::role', 'default_value' => {} , merge => hash })
  $pg_hba_rule = lookup({ 'name' =>'scriptura::iac::management::backenddb::pg_hba_rule', 'default_value' => {} , merge => hash })

  create_resources('postgresql::server::db',$database)
  create_resources('postgresql::server::database_grant',$database_grant)
  create_resources('postgresql::server::role',$role)
  create_resources('postgresql::server::pg_hba_rule',$pg_hba_rule)

}
