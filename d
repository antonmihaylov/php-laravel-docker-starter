#!/bin/bash
DIR="$(dirname "$(readlink -f "$0")")"

first_arg="$1"
shift

available_commands="build, up, down, rebuild, clean, stop, new, run, exec, npm, composer, artisan"

if [ "$first_arg" = "build" ]; then
    cd "$DIR" || exit
    sudo docker-compose build
elif [ "$first_arg" = "up"  ]; then
    cd "$DIR" || exit
    docker-compose up -d
elif [ "$first_arg" = "down"  ]; then
    cd "$DIR" || exit
    docker-compose down
elif [ "$first_arg" = "rebuild"  ]; then
    cd "$DIR" || exit
    sudo docker-compose down && sudo docker-compose build && docker-compose up -d
elif [ "$first_arg" = "clean"  ]; then
    cd "$DIR" || exit
    sudo docker-compose down && sudo docker-compose build
elif [ "$first_arg" = "new" ] && [ "$1" == "laravel" ]; then
    cd "$DIR" || exit
  docker-compose run --rm --entrypoint=composer laravel create-project --prefer-dist laravel/laravel .
elif [ "$first_arg" = "run"  ]; then
    cd "$DIR" || exit
  docker-compose run --rm "$@"
elif [ "$first_arg" = "exec"  ]; then
    cd "$DIR" || exit
  docker-compose exec "$@"
elif [ "$first_arg" = "npm"  ]; then
    cd "$DIR" || exit
  docker-compose run --rm npm "$@"
elif [ "$first_arg" = "composer"  ]; then
    cd "$DIR" || exit
  docker-compose run --rm composer "$@"
elif [ "$first_arg" = "artisan"  ]; then
    cd "$DIR" || exit
  docker-compose run --rm artisan "$@"
elif [ "$first_arg" = "a"  ]; then
    cd "$DIR" || exit
  docker-compose run --rm artisan "$@"
elif [ "$first_arg" = "perm"  ]; then
  sudo chmod -R a+rw src
elif [ -z "$first_arg" ]; then
      echo "Enter a command. Available commands: $available_commands"
else
    echo "Command $first_arg not recognized. Available commands: $available_commands"
fi
