alias sudo='sudo '
alias doc="docker-compose"
alias do="docker"
alias docr="docker-compose run --rm"
alias docrb="docker-compose down && sudo docker-compose build && docker-compose up -d"
alias lardocnew = "docker-compose run --rm --entrypoint=composer laravel create-project --prefer-dist laravel/laravel ."
