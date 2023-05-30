#!/usr/bin/env bash

echoerr() {
    echo "$1" >&2
}

pipenv_bin() {
    echo "$RTX_INSTALL_PATH/asdf_bin/pipenv"
}

pipenv_venv() {
    local pipfile
    pipfile="$(eval "echo ${RTX_TOOL_OPTS__PIPFILE:-}")"
    if [ "$pipfile" = "" ]; then
        return
    fi
    if [[ "$pipfile" != /* ]] && [[ -n "${RTX_PROJECT_ROOT:-}" ]]; then
        pipfile="${RTX_PROJECT_ROOT:-}/$pipfile"
    fi
    if [[ ! -f "$pipfile" ]]; then
        echoerr "rtx-pipenv: no Pipfile found at $pipfile"
        exit 1
    fi

    pipenv_venv_dir="$("$(pipenv_bin)" --venv 2>/dev/null)"
    echo "${pipenv_venv_dir:-pipfile found without venv}"
}
