# tika
#
# Main class, includes all other classes.
#
# @param source_server [Optional[String]] URL to the .jar of the tika server software
# @param source_app [Optional[String]]  URL to the .jar of the tika app software
class tika (
    $source_server = $tika::params::source_server,
    $source_app    = $tika::params::source_app,
) inherits tika::params {
    class { 'tika::install': } ->
        class { 'tika::service': }
}
