# php-laravel-docker-starter
A simple starter for Laravel (or other php) applications for complete environment isolation with Docker

# What does it have?
- Dockerfiles for development tools: 
  - php, artisan, composer, laravel, npm
- Docker-compose configuration for setting up a network of:
  - a nginx server, serving by default content in src/public/
  - the php application (located in src/)
  - a database, currently configured to Postgres
  - the development tools - artisan, composer, npm, laravel
 - A build script (./d) for most commong commands

With having all of the devopment tools containerized you can have a clean development environment, where you don't need to install any of them on your machine. That allows for very easy workfolow between several different machines and minimises conflicts when working with multiple projects

# How to use:
- Clone the repo
- Build the docker images:
  `docker-compose build`  or `./d build)`
- To test it - add an simple index.html file in src/public/. 
    (If you're having problems with permissions inside the src folder do:
 `sudo chmod -R o+rw ./src`)
 
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
- `./d exec` - the same as run, but executes it on a running container


# NOTE!
This configuration is far from perfect and serves as a starting point for a development environment. It is not yet tested in production, use at your own risk if you're going to deploy any of the docker configurations.

The repository was only tested on Linux (Ubuntu 20.0)

If you're having problems with permissions inside the src folder do:
 `sudo chmod -R o+rw ./src`

Feel free to offer changes, create issues and make pull requests.
Have fun coding!
