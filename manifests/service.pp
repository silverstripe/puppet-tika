# @api private
# This class handles the tika service. Avoid modifying private classes.
class tika::service inherits tika {

    validate_string($tika::params::service_name)
    validate_bool($tika::params::service_enable)

    if !($tika::params::service_ensure in ['running', 'stopped']) {
        fail('service_ensure parameter must be running or stopped')
    }

    # http://apache-tika-users.1629097.n2.nabble.com/systemd-script-td7573728.html
    servicetools::install_systemd_unit { $tika::params::service_name :
        unit_options    => {
            'Description' => 'Apache Tika Server',
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
        service_ensure  => $tika::params::service_ensure,
        service_enable  => $tika::params::service_enable,
        require         => File['/opt/tika/tika-server.jar']
    }
}
