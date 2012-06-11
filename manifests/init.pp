class newrelic(
    $license   = $::newrelic_license,
    $reporting = true,
) {
    include newrelic::repo
    include newrelic::package
    class {"newrelic::server":
        license   => $license,
        reporting => $reporting,
    }
}
