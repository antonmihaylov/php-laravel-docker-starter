#!/bin/bash

#Set this to the absolute path to this script if you're having problems with it
SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"



SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

cdScriptDir() {
    cd "$SCRIPT_DIR" || {
        echo "Couldn't find directory of the current bash script. Set the SCRIPT_PATH in this script as a workaround"
        exit 1
    }
}

ENV_PATH=$SCRIPT_DIR/".env"
PATH_TO_APP=$(grep PATH_TO_APP "$ENV_PATH" | grep -v -P '^\s*#' | cut -d '=' -f 2-)
APP_NAME=$(grep APP_NAME "$ENV_PATH" | grep -v -P '^\s*#' | cut -d '=' -f 2-)

export COMPOSE_PROJECT_NAME=$APP_NAME

cdAppDir() {
    cd "$PATH_TO_APP" || {
        echo "Couldn't find your app's directory. Have you correctly set the PATH_TO_APP in your .env file?"
        exit 1
    }
}

first_arg="$1"
shift

available_commands="build, up, down, rebuild, clean, stop, new laravel, run, exec, npm, composer, artisan"

if [ "$first_arg" = "build" ]; then
    cdScriptDir
    sudo docker-compose build
elif [ "$first_arg" = "up" ]; then
    cdScriptDir
    docker-compose up -d
elif [ "$first_arg" = "down" ]; then
    cdScriptDir
    docker-compose down
elif [ "$first_arg" = "rebuild" ]; then
    cdScriptDir
    sudo docker-compose down && sudo docker-compose build && docker-compose up -d
elif [ "$first_arg" = "clean" ]; then
    cdScriptDir
    sudo docker-compose down && sudo docker-compose build
elif [ "$first_arg" = "new" ] && [ "$1" == "laravel" ]; then
    cdScriptDir
    docker-compose run --rm --entrypoint=composer laravel create-project --prefer-dist laravel/laravel .
elif [ "$first_arg" = "run" ]; then
    cdScriptDir
    docker-compose run --rm "$@"
elif [ "$first_arg" = "exec" ]; then
    cdScriptDir
    docker-compose exec "$@"
elif [ "$first_arg" = "npm" ]; then
    cdScriptDir
    docker-compose run --rm npm "$@"
elif [ "$first_arg" = "composer" ]; then
    cdScriptDir
    docker-compose run --rm composer "$@"
elif [ "$first_arg" = "artisan" ]; then
    cdScriptDir
    docker-compose run --rm artisan "$@"
elif [ "$first_arg" = "a" ]; then
    cdScriptDir
    docker-compose run --rm artisan "$@"
elif [ "$first_arg" = "perm" ]; then
    cdAppDir
    sudo chmod -R a+rw ./
elif [ -z "$first_arg" ]; then
    echo "Enter a command. Available commands: $available_commands"
else
    echo "Command $first_arg not recognized. Available commands: $available_commands"
fi
