# @api private
# This class handles the tika parameters.
class tika::params {
    $version = '1.14'
    $server_jar_url = undef
    $app_jar_url    = undef
    $service_enable = true
    $service_ensure = 'running'
    $service_manage = true
    $service_name = 'tika'
}
