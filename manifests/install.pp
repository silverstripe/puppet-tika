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

    servicetools::install_file { '/opt/tika/tika-server.jar':
        source  => $tika::params::source_server,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => [ File['tika_home_dir' ] ]
    }

    servicetools::install_file { '/opt/tika/tika-app.jar':
        source  => $tika::params::source_app,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => [ File['tika_home_dir' ] ]
    }

    file { 'tika_app_bin':
        ensure  => file,
        path    => '/usr/local/bin/tika',
        require => [
            File['/opt/tika/tika-app.jar'],
        ],
        owner   => root,
        group   => root,
        mode    => '0755',
        content => '#!/usr/bin/env bash\nexec java -jar /opt/tika/tika-app.jar \'$@\'',
    }
}
