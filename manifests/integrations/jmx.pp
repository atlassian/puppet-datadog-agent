# Class: datadog_agent::integrations::jmx
#
# This class will install the necessary configuration for the Marathon integration
#
# Parameters:
#   $host
#       Host the java process is running on. Defaults to 'localhost'.
#   $port
#       The JMX port. Defaults to '7199'.
#   $username
#       The username for connecting to the running JVM. Optional.
#   $password
#       The password for connecting to the running JVM. Optional.
#   $process_name_regex
#       Process regex to use the running JVM. Use this instead of hostname and port. Optional.
#   $tools_jar_path
#       To be set if $process_name_regex is set. Optional.
#   $java_bin_path
#       The path to the Java binary. Should be set if the agent cannot find your java executable. Optional.
#   $trust_store_path
#       The path to the trust store. Should be set if ssl is enabled. Optional.
#   $trust_store_password
#       The trust store password. Should be set if ssl is enabled. Optional.
#   $tags
#       Optional hash of tags { env => 'prod' }.
#   $includes
#       Custome domains to include. Optional.
#
# Sample Usage:
#
#   class { 'datadog_agent::integrations::jmx' :
#     host => "localhost"
#     port => "7199"
#   }
#
class datadog_agent::integrations::jmx(
  $host                 = 'localhost',
  $port                 = 7199,
  $username             = undef,
  $password             = undef,
  $process_name_regex   = undef,
  $tools_jar_path       = undef,
  $java_bin_path        = undef,
  $trust_store_path     = undef,
  $trust_store_password = undef,
  $tags                 = {},
  $includes             = {},
) inherits datadog_agent::params {

  file { "${datadog_agent::params::conf_dir}/jmx.yaml":
    ensure  => file,
    owner   => $datadog_agent::params::dd_user,
    group   => $datadog_agent::params::dd_group,
    mode    => '0644',
    content => template('datadog_agent/agent-conf.d/jmx.yaml.erb'),
    require => Package[$datadog_agent::params::package_name],
    notify  => Service[$datadog_agent::params::service_name]
  }
}
