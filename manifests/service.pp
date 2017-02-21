# @api private
# This class handles the tika service. Avoid modifying private classes.
class tika::service inherits tika {

    validate_string($tika::service_user)
    validate_string($tika::service_name)
    validate_bool($tika::service_enable)

    if !($tika::service_ensure in ['running', 'stopped']) {
        fail('service_ensure parameter must be running or stopped')
    }

    servicetools::install_systemd_unit { $tika::service_name :
        unit_options    => {
            'Description' => 'Apache Tika Server',
            'After'       => 'network.target',
            'Requires'    => 'network.target'
        },
        service_options => {
            'User'       => $tika::service_user,
            'ExecStart'  => "/usr/bin/java -jar ${tika::install_dir}/tika-server-${tika::version}.jar --host=localhost --port=9998",
            'RestartSec' => 15,
            'Restart'    => 'always',
        },
        install_options => {
            'WantedBy' => 'multi-user.target',
        },
        service_ensure  => $tika::service_ensure,
        service_enable  => $tika::service_enable,
        require         => Servicetools::Install_file['tika-server-binary'],
    }
}
