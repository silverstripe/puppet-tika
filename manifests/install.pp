# @api private
# This class handles tika install. Avoid modifying private classes.
class tika::install inherits tika {

    file { 'tika_home_dir':
        ensure  => directory,
        path    => '/opt/tika',
        recurse => true,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
    }

    $real_server_jar_url = "https://archive.apache.org/dist/tika/tika-server-${tika::params::version}.jar"
    if $tika::params::server_jar_url != undef {
        $real_server_jar_url = $tika::params::server_jar_url
    }

    servicetools::install_file { '/opt/tika/tika-server.jar':
        source  => $real_server_jar_url,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => [ File['tika_home_dir' ] ]
    }

    $real_app_jar_url = "https://archive.apache.org/dist/tika/tika-app-${tika::params::version}.jar"
    if $tika::params::app_jar_url != undef {
        $real_app_jar_url = $tika::params::app_jar_url
    }

    servicetools::install_file { '/opt/tika/tika-app.jar':
        source  => $real_app_jar_url,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => [ File['tika_home_dir' ] ]
    }

    file { 'tika_app_bin':
        ensure  => file,
        path    => '/usr/local/bin/tika',
        require => [ File['/opt/tika/tika-app.jar'] ],
        owner   => root,
        group   => root,
        mode    => '0755',
        content => '#!/usr/bin/env bash\nexec java -jar /opt/tika/tika-app.jar \'$@\'',
    }
}
