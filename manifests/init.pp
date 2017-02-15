class tika (

) inherits tika::params {
	class { "tika::install": }->
	class { "tika::config": }->
	class { "tika::service": }

}
