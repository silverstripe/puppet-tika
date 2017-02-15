class tika (
	$source_server = $tika::params::source_server,
	$source_app = $tika::params::source_app,

) inherits tika::params {
	class { "tika::install": }->
	class { "tika::config": }->
	class { "tika::service": }

}
