class tika::install inherits tika {


	file { "tika_home_dir":
		path => '/opt/tika',
		ensure => directory,
		recurse => true,
		owner => "root",
		group => "root",
		mode => "0755",
	}

	servicetools::install_file { "/opt/tika/tika-server.jar":
		source => $source_server,
		owner => "root",
		group => "root",
		mode => "0644",
		require => [ File["tika_home_dir" ] ]
	}

	servicetools::install_file { "/opt/tika/tika-app.jar":
		source => $source_app,
		owner => "root",
		group => "root",
		mode => "0644",
        require => [ File["tika_home_dir" ] ]
	}

	# http://apache-tika-users.1629097.n2.nabble.com/systemd-script-td7573728.html
	servicetools::install_systemd_unit { "tika":
		unit_options => {
			"Description" => "Apache Tika server",
			"After" => "network.target",
			"Requires" => "network.target"
		},
		service_options => {
			"User" => "www-data",
			"ExecStart" => "/usr/bin/java -jar /opt/tika/tika-server.jar --host=localhost --port=9998",
			"RestartSec" => 15,
			"Restart" => "always",
		},
		install_options => {
			"WantedBy" => "multi-user.target",
		},
		service_ensure => "running",
		service_enable => true,
		require => File["/opt/tika/tika-server.jar"]
	}

	file { 'tika_app_bin':
		path => '/usr/local/bin/tika',
		ensure => file,
		require => [
			File["/opt/tika/tika-app.jar"],
		],
		owner => root,
		group => root,
		mode => 0755,
		content => "#!/usr/bin/env bash\nexec java -jar /opt/tika/tika-app.jar \"$@\"",
	}
}