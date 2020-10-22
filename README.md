# php-laravel-docker-starter
A simple starter for Laravel (or other php) applications for complete environment isolation with Docker

The shell script (./d) is currently designed to work with Linux. Can't guarantee that it will work on other platforms. 

# What does it have?
- Dockerfiles for development tools: 
  - php, artisan, composer, laravel, npm
- Docker-compose configuration for setting up a network of:
  - a nginx server, serving by default content from the {PATH_TO_APP}/public/
  - the php application
  - a database, currently configured to Postgres
  - development tools - artisan, composer, npm, laravel
 - A build script (./d) for the most common commands

With having all the development tools containerized you can have a clean development environment, where you don't need to install any of them on your machine. That allows for very easy workfolow between several different machines and minimises conflicts when working with multiple projects

# How to use:
- Clone the repo (usually in a folder inside your root app folder, e.g. my-app/php-laravel-docker-starter)
- cd into the folder
    - Note: to use the "./d" script you must give it exec permission using "chmod +x ./d"
    - Note 2: if you're on linux you can create a link from your app root to the ./d file, so that you can call it from the app root. While in your app root call `ln php-laravel-docker-starter/d` 
- Build the docker images:
  `docker-compose build`  or `./d build)`
- Set your variables in .env:
    - APP_NAME - this is the name of your app. Will be used to name the docker containers
    - PATH_TO_APP - an absolute or relative path to your app root
- To test it you can:
    - add an simple index.html file in {PATH_TO_APP}/public/ 
    (If you're having problems refer to the Troubleshooting section)
        OR
    - create a laravel app with `./d new laravel`
    - Note that all containers have their workdir set to the PATH_TO_APP

- Run the containers:
    `docker-compose up -d` or `./d up`
- Go to localhost:8080 and see if your test html file comes up
- If you want to change something, you don't need to rebuild the docker images or to restart the containers. Just edit the html file and refresh your browser.
- Shut down the containers:
  `docker-compose down` or `./d down`
  
# Config
- Nginx: the nginx/default.conf is the default configuration for nginx. You can add more configuration files in the nginx.dockerfiles
- Postgres: change the db service settings inside the docker-compose.yaml file. Note: the psql folder is there for persisting the data from the database. If you don't want to persist it across docker sessions remove the `- ./psql:/var/lib/postgresql/data` volume from the docker-compose.yaml
- Php: you can add extensions in the php.dockerfile. Append the extensions to the last line: `RUN docker-php-ext-install pdo pgsql pdo_pgsql  [YOUR EXTENSION HERE]`

# All commands:
- `./d build` - builds the docker compose images, equivalent to `docker-compose build`
- `./d up` - starts the docker compose services, equivalent to `docker-compose up -d`
- `./d down` - stops the docker compose services, equivalent to `docker-compose down`
- `./d rebuild` - stops running services, builds the images and starts then again, equivalent to calling down, build and up
- `./d clean` - stops running services and builds the images
- `./d new laravel` - creates a new Laravel application in the src/ directory
- `./d run *service name* *command*` - creates a container, runs a command in it and closes it. See service names in the docker-compose files (default: app, db, nginx, composer, npm, artisan, laravel. Note that the working dir in the container is the one mapped to the src/ dir. So, for example, to run npm install on a package.json that is in src/package.json you run `./d run npm install`. Note that npm here is the name of the service, the npm is the default entrypoint, so any command is related to the npm runtime.  
- `./d exec *service name* *command*` - the same as run, but executes it on a running container
- `./d npm *command*` - shortcut for run npm *command*
- `./d composer *command*` - shortcut for run composer *command*
- `./d artisan *command*` - shortcut for run artisan *command*
- `./d a *command*` - shortcut for run artisan *command*
- `./d perm` - shortcut for sudo chmod -R a+rw src


# NOTE!
This configuration is far from perfect and serves as a starting point for a development environment. It is not yet tested in production, use at your own risk if you're going to deploy any of the docker configurations.

The repository is tested only on Linux (Ubuntu 20.0)

# Troubleshooting
- If you're having problems with permissions inside the src folder run (on your machine):
 ` sudo chmod -R a+rw src`. Since that can happen often, there is a shortcut - `./d perm` Note - you need to rerun this if you've generated a Laravel app.

Feel free to offer changes, create issues and make pull requests.
Have fun coding!
