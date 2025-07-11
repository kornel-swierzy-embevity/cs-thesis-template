#!/bin/bash
###########################################################
# Author: Kornel Swierzy
# Date:   2025-07-11
# Brief:  Common task automation
###########################################################

# Includes

# Constants

readonly ScriptDir="$(dirname -- "$( readlink -f -- "${0}"; )";)"
readonly ScriptName="$(basename "${0}")"
readonly RootDir="$( readlink -f -- "${ScriptDir}/.."; )"

readonly CLIModeBuildPdf="build-pdf"
readonly CLIModeBuildDocker="build-docker"
readonly CLIModeRunDocker="run-docker"

readonly MainFile="main.tex"
readonly BuildDir="_build"
readonly DeployDir="_deploy"
readonly DockerComposeService="cs-thesis-template"

# Global variables

CLIMode="${CLIModeBuildPdf}"

ExitStatus=0

# Private functions

## Logging
log_date() {
    date
}

log_raw() {
    echo "${@}" 1>&2
}

log() {
    log_raw "$(log_date) : ${@}"
}

die() {
    log "$@"
    exit 1
}

## CLI interface

cli_printUsage() {
    log_raw "Usage: ${ScriptName} [OPTION]"
    log_raw "  --help           - prints help"
    log_raw "  --mode           - selects mode, default: ${CLIModeBuildPdf}, one of:"
    log_raw "                   ${CLIModeBuildPdf} - builds thesis in pdf format"
    log_raw "                   ${CLIModeBuildDocker} - builds development environment"
    log_raw "                   ${CLIModeRunDocker} -starts development environment"
}

cli_parseArguments() {
    while [ $# -ge 1 ]; do
        case "${1}" in
            "--mode")
                CLIMode="${2}"; shift 2
            ;;
            "--help")
                cli_printUsage
                exit 0
            ;;
            *)
                cli_printUsage
                exit 1
            ;;
        esac
    done
}

buildPdf() {
    mkdir -p "${BuildDir}/chapters"

    latexmk -outdir="${BuildDir}" -pdf "${MainFile}"
    if [ $? -eq 0 ]; then
        mkdir -p ${DeployDir}
        cp "${BuildDir}/main.pdf" "${DeployDir}/main.pdf"
    else
        log "Failed to generate pdf!"
        ExitStatus=1
    fi
}

buildDocker() {
    type "docker-compose" >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        docker-compose build "${DockerComposeService}"
    else
        docker compose build "${DockerComposeService}"
    fi
}

runDocker() {
    local __Command=""

    type "docker-compose" >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        __Command="docker-compose"
    else
        __Command="docker compose"
    fi

    ${__Command} run -e LOCAL_USER_ID=$(id -u) -e LOCAL_GROUP_ID=$(id -g) "${DockerComposeService}" bash
}

# Main

cli_parseArguments $@

if [ "${CLIMode}" == "${CLIModeBuildPdf}" ]; then
    buildPdf
elif [ "${CLIMode}" == "${CLIModeBuildDocker}" ]; then
    buildDocker
elif [ "${CLIMode}" == "${CLIModeRunDocker}" ]; then
    runDocker
else
    die "Invalid mode selected : ${CLIMode}!"
fi

exit "${ExitStatus}"
