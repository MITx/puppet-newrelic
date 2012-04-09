class newrelic::repo {
    case $::operatingsystem {
        /Debian|Ubuntu/: {
            file { "/etc/apt/trusted.gpg.d/newrelic.gpg":
                source => "puppet:///newrelic/APT-GPG-KEY-NewRelic.gpg",
                owner  => "root",
                group  => "root",
                mode   => 0644,
            }
            exec { newrelic-add-apt-repo:
                creates => "/etc/apt/sources.list.d/newrelic.list",
                command => "wget -O /etc/apt/sources.list.d/newrelic.list http://download.newrelic.com/debian/newrelic.list",
            }
            exec { newrelic-apt-get-update:
                refreshonly => true,
                subscribe   => [File["/etc/apt/trusted.gpg.d/newrelic.gpg"], Exec["newrelic-add-apt-repo"]],
                command     => "apt-get update",
            }
        }
        default: {
            file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-NewRelic":
                owner   => root,
                group   => root,
                mode    => 0644,
                source  => "puppet:///newrelic/RPM-GPG-KEY-NewRelic";
            }

            yumrepo { "newrelic":
                baseurl     => "http://yum.newrelic.com/pub/newrelic/el5/\$basearch",
                enabled     => "1",
                gpgcheck    => "1",
                gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-NewRelic";
            }
        }
    }
}
