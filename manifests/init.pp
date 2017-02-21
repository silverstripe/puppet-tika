# tika
#
# Main class, includes all other classes.
#
# @param version [String]] version of tika installed, used so that it's easy to upgrade tika version
# @param server_jar_url [Optional[String]] URL to the tika server software to file to install
# @param app_jar_url [Optional[String]] URL to the tika app .jar file to install
# @param install_dir [Optional[String]] base folder where the tika binaries will be installed
# @param service_enable [Optional[String]]
# @param service_ensure [Optional[String]]
# @param service_manage [Optional[String]]
# @param service_name [Optional[String]]
# @param service_user [Optional[String]]
class tika (
    $version = $tika::params::version,
    $server_jar_url = $tika::params::server_jar_url,
    $app_jar_url    = $tika::params::app_jar_url,
    $install_dir = $tika::params::install_dir,
    $service_enable = $tika::params::service_enable,
    $service_ensure = $tika::params::service_ensure,
    $service_manage = $tika::params::service_manage,
    $service_name = $tika::params::service_name,
    $service_user = $tika::params::service_user
) inherits tika::params {
    class { 'tika::install': } ->
    class { 'tika::service': }
}
