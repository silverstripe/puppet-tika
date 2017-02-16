# tika
#
# Main class, includes all other classes.
#
# @param version [Optional[String]]
# @param source_server [Optional[String]] URL to the tika server software to file to install, overrides $version
# @param source_app [Optional[String]] URL to the tika app .jar file to install, overrides $version
# @param service_enable [Optional[String]]
# @param service_ensure [Optional[String]]
# @param service_manage [Optional[String]]
# @param service_name [Optional[String]]
class tika (
    $version = $tika::params::version,
    $server_jar_url = $tika::params::server_jar_url,
    $app_jar_url    = $tika::params::app_jar_url,
    $service_enable = $tika::params::service_enable,
    $service_ensure = $tika::params::service_ensure,
    $service_manage = $tika::params::service_manage,
    $service_name = $tika::params::service_name,
) inherits tika::params {
    class { 'tika::install': } ->
    class { 'tika::service': }
}
