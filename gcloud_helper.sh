#!/usr/bin/env bash

project_exists() {
    local project="${1}"

    if [[ -z "${project}" ]]; then
        echo
        echo "Usage: project_exists <project>"
        echo
        exit 1
    fi
    
    gcloud projects describe "${project}" --no-user-output-enabled 2> /dev/null
    echo $?
}

secret_exists() {
    local project="${1}"
    local secret="${2}"

    if [[ -z "${project}" ]] || [[ -z "${secret}" ]]; then
        echo
        echo "Usage: secret_exists <project> <secret>"
        echo
        exit 1
    fi

    gcloud secrets describe "${secret}" --project="${project}" --no-user-output-enabled 2> /dev/null
    echo $?
}

get_secret() {
    local project="${1}"
    local secret="${2}"

    if [[ -z "${project}" ]] || [[ -z "${secret}" ]]; then
        echo
        echo "Usage: get_secret <project> <secret>"
        echo
        exit 1
    fi

    local password="$( gcloud secrets versions access latest --secret="${secret}" --project="${project}" )"

    [[ $? -eq 0 ]] && echo "${password}" || { echo "Secret ( ${secret} ) not found."; exit 1; }
}

create_secret() {
    local project="${1}"
    local secret_name="${2}"
    local secret_value="${3}"

    if [[ -z "${project}" ]] || [[ -z "${secret_name}" ]] || [[ -z "${secret_value}" ]]; then
        echo
        echo "Usage: create_secret <project> <secret-name> <secret-value>"
        echo
        exit 1
    fi

    if [[ $( secret_exists "${project}" "${secret_name}" ) -eq 0 ]]; then
        echo "  Secret already exists."
    else
        echo
        echo "  Creating GSM Secret: ${secret_name}"
        gcloud secrets create "${secret_name}" --project="${project}" --no-user-output-enabled 2> /dev/null

        [[ $? -ne 0 ]] && { echo "  Failed to create secret. Exiting."; exit 1; }

        echo "${secret_value}" | gcloud secrets versions add "${secret_name}" --data-file=- --project="${project}" --no-user-output-enabled 2> /dev/null

        [[ $? -ne 0 ]] && { echo "  Failed to add secret value. Exiting."; exit 1; }

        echo "  -> Verifying secret was updated successfully:"
        local secret_check="$( get_secret "${project}" "${secret_name}" )"

        if [[ "${secret_check}" == "${secret_value}" ]]; then
            echo "     -> Secret validated."
        else
            echo "     -> Secret validation failed. Exiting."
            exit 1
        fi
    fi
}

update_secret() {
    local project="${1}"
    local secret_name="${2}"
    local secret_value="${3}"

    if [[ -z "${project}" ]] || [[ -z "${secret_name}" ]] || [[ -z "${secret_value}" ]]; then
        echo
        echo "Usage: update_secret <project> <secret_name> <secret_value>"
        echo
        exit 1
    fi

    # For some reason, success here returns an exit(1). I hate the gcloud CLI.
    echo "${secret_value}" | gcloud secrets versions add "${secret_name}" --data-file=- --project="${project}" --no-user-output-enabled &>/dev/null || true
}
