#!/usr/bin/env bash

cloudsql_proxy_start() {
    local project="${1}"
    local instance="${2}"
    port="${3:-3306}"
    local region="${4:-us-central1}"

    # Kill it if it's running.
    cloudsql_proxy_running

    nohup cloud_sql_proxy -instances="${project}:${region}:${instance}=tcp:${port}" -log_debug_stdout -quiet &>/dev/null &
    csqlproxy_pid=$!
    sleep 1
}

cloudsql_proxy_running() {
    local result=$( ps | grep cloud_sql_proxy | grep "${port}" | awk '{print $1}')
    if [[ -n "${result}" ]]; then
        cloudsql_proxy_stop "${result}"
    fi
}

cloudsql_proxy_stop() {
    local csqlproxy_pid="${1:-fail}"
    kill "${csqlproxy_pid}" 2>/dev/null
}
