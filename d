#!/bin/bash

first_arg="$1"
shift

available_commands="build, up, down, rebuild, clean, stop, new, run, exec, npm, composer"

if [ "$first_arg" = "build" ]; then
    sudo docker-compose build
elif [ "$first_arg" = "up"  ]; then
    docker-compose up -d
elif [ "$first_arg" = "down"  ]; then
    docker-compose down
elif [ "$first_arg" = "rebuild"  ]; then
    sudo docker-compose down && sudo docker-compose build && docker-compose up -d
elif [ "$first_arg" = "clean"  ]; then
    sudo docker-compose down && sudo docker-compose build
elif [ "$first_arg" = "new" ] && [ "$1" == "laravel" ]; then
  docker-compose run --rm --entrypoint=composer laravel create-project --prefer-dist laravel/laravel .
elif [ "$first_arg" = "run"  ]; then
  docker-compose run --rm "$@"
elif [ "$first_arg" = "exec"  ]; then
  docker-compose exec "$@"
elif [ "$first_arg" = "npm"  ]; then
  docker-compose run --rm npm "$@"
elif [ "$first_arg" = "composer"  ]; then
  docker-compose run --rm composer "$@"
elif [ -z "$first_arg" ]; then
      echo "Enter a command. Available commands: $available_commands"
else
    echo "Command $first_arg not recognized. Available commands: $available_commands"
fi