# @api private
# This class handles the tika parameters.
class tika::params {
    $version =  undef
    $server_jar_url = undef
    $app_jar_url    = undef
    $install_dir = '/opt/tika'
    $service_enable = true
    $service_ensure = 'running'
    $service_manage = true
    $service_name = 'tika'
    $service_user = 'www-data'
}
