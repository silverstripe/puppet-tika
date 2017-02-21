# @api private
# This class handles tika install. Avoid modifying private classes.
class tika::install inherits tika {

    if $tika::version == undef {
        fail('tika::version is required')
    }

    file { 'tika_home_dir':
        ensure => directory,
        path   => $tika::install_dir,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
    }

    if $tika::server_jar_url != undef {
        $real_server_jar_url = $tika::server_jar_url
    } else {
        $real_server_jar_url = "https://archive.apache.org/dist/tika/tika-server-${tika::version}.jar"
    }

    servicetools::install_file { 'tika-server-binary':
        target  => "${tika::install_dir}/tika-server-${tika::version}.jar",
        source  => $real_server_jar_url,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => [ File['tika_home_dir' ] ]
    }

    if $tika::app_jar_url != undef {
        $real_app_jar_url = $tika::app_jar_url
    } else {
        $real_app_jar_url = "https://archive.apache.org/dist/tika/tika-app-${tika::version}.jar"
    }

    servicetools::install_file { 'tika-app-binary':
        target  => "${tika::install_dir}/tika-app-${tika::version}.jar",
        source  => $real_app_jar_url,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => [ File['tika_home_dir' ] ]
    }

    file { 'tika_app_bin':
        ensure  => file,
        path    => '/usr/local/bin/tika',
        require => Servicetools::Install_file['tika-app-binary'],
        owner   => root,
        group   => root,
        mode    => '0755',
        content => "#!/usr/bin/env bash\nexec java -jar /opt/tika/tika-app.jar \'$@\'",
    }
}
