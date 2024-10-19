#!/usr/bin/env bash

cloudsql_instance_exists() {
    local project="${1}"
    local instance="${2}"

    if [[ -z "${project}" ]] || [[ -z "${instance}" ]]; then
        echo
        echo "Usage: cloudsql_instance_exists <project> <instance>"
        echo
        exit 1
    fi

    gcloud sql instances describe "${instance}" --project="${project}" --no-user-output-enabled &>/dev/null
    echo $?
}

cloudsql_user_exists() {
    local project="${1}"
    local instance="${2}"
    local user="${3}"

    if [[ -z "${project}" ]] || [[ -z "${instance}" ]] || [[ -z "${user}" ]]; then
        echo
        echo "Usage: cloudsql_user_exists <project> <instance> <user>"
        echo
        exit 1
    fi

    gcloud sql users list --instance="${instance}" --project="${project}" --no-user-output-enabled | grep "${user}" &>/dev/null
    echo $?
}

cloudsql_create_superuser() {
    local project="${1}"
    local instance="${2}"
    local username="${3}"
    local hostspec="${4:-%}"

    if [[ -z "${project}" ]] || [[ -z "${instance}" ]] || [[ -z "${username}" ]]; then
        echo
        echo "WARNING: This will create a very privileged user."
        echo
        echo "Usage: cloudsql_create_user <project> <instance> <username> [hostspec]"
        echo "                                                            Default: %"
        echo
    fi

    gcloud sql users create "${username}" --host="${hostspec}" --instance="${instance}" --project="${project}" --password="$( generate_password )"--no-user-output-enabled &>/dev/null

    if [[ $? -eq 0 ]]; then
        echo "User created successfully."
    else
        echo "User creation failed."
    fi
}

cloudsql_delete_user() {
    local project="${1}"
    local instance="${2}"
    local username="${3}"

    if [[ -z "${project}" ]] || [[ -z "${instance}" ]] || [[ -z "${username}" ]]; then
        echo
        echo "Usage: cloudsql_delete_user <project> <instance> <user>"
        echo
        exit 1
    fi

    gcloud sql users delete "${username}" --instance="${instance}" --project="${project}" --no-user-output-enabled &>/dev/null

    if [[ $? -eq 0 ]]; then
        echo "User deleted successfully."
    else
        echo "User deletion failed."
    fi
}