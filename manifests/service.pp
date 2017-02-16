# @api private
# This class handles the tika service. Avoid modifying private classes.
class tika::service inherits tika {

    # http://apache-tika-users.1629097.n2.nabble.com/systemd-script-td7573728.html
    servicetools::install_systemd_unit { 'tika':
        unit_options    => {
            'Description' => 'Apache Tika server',
            'After'       => 'network.target',
            'Requires'    => 'network.target'
        },
        service_options => {
            'User'       => 'www-data',
            'ExecStart'  => '/usr/bin/java -jar /opt/tika/tika-server.jar --host=localhost --port=9998',
            'RestartSec' => 15,
            'Restart'    => 'always',
        },
        install_options => {
            'WantedBy' => 'multi-user.target',
        },
        service_ensure  => 'running',
        service_enable  => true,
        require         => File['/opt/tika/tika-server.jar']
    }
}
