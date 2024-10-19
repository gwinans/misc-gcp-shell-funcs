#!/usr/bin/env bash

prompt_confirm() {
    local prompt="${1}"
    while true; do
        read -r -n 1 -p "${prompt} [y/n]: " REPLY
        case "${REPLY}" in
            [Yy]) echo ; return 0 ;;
            [Nn]) echo ; return 1 ;;
            *)    echo "Only Y and N are valid inputs." ;;
        esac
    done
}

generate_password() {
    local length="${1:-24}"
    local password="$( LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c "${length}" )"
    echo "${password}"
}
