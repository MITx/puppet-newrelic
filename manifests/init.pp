class newrelic($license  = $::newrelic_license) {
    include newrelic::repo
    include newrelic::package
    class {"newrelic::server":
        license => $license
    }
}
