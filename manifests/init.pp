class newrelic (
    $newrelic_license
    ) {
    class { 'newrelic::repo': }
    class { 'newrelic::package': }
    class { 'newrelic::server': newrelic_license => $newrelic_license }
}
