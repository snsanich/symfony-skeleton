General Backend Template Project
===================================

**If you need Vagrant + Ansible version, please check [vagrant_ansible](https://github.com/intellectsoft-uk/symfony-skeleton/tree/vagrant_ansible) branch.**

## What's included

This is our day-to-day backend dev stack

 - Pre-configured PHP 7 FPM and CLI
 - Pre-configured Nginx 1.9
 - PostgreSQL 9.4
 - Symfony 3.0 standard edition
 - Doctrine ORM 2.5
 - FosRestBundle
 - Behat and PhpSpec as testing frameworks

## Required software

 - Docker 1.9+
 - Docker-compose 1.6+
 - Docker-machine 0.6+

### Docker

All environment isolated from host system via Docker containers.

For understanding of how Docker works please read this articles:

 - [About Docker](http://www.wintellect.com/devcenter/paulballard/what-developers-need-to-know-about-docker)
 - [Visualizing Docker Containers and Images](http://merrigrove.blogspot.com.by/2015/10/visualizing-docker-containers-and-images.html)
 - [Docker Documentation](https://docs.docker.com/engine/misc/)
 - [Docker Compose Documentation](https://docs.docker.com/compose/)

PHP container uses `boot.sh` as default command. It runs migrations ono startup.

### For MAC OSX users

To run Docker images you should have linux kernel. This could be a tiny problem for Mac OSX users. We recommend to use [docker-machine](https://docs.docker.com/v1.8/installation/mac/) or [dinghy](https://github.com/codekitchen/dinghy).

### Aliases

To simplify your life, you can use aliases available in `support/aliases` shell script. I recommend you to add alias on your `.bashrc` or `.bash_profile`:

```
alias run="./support/aliases"
```

By doing this, you will be able to use short versions of commands:

```bash
run php --version               # prints version of php running in container
run console --version           # prints version of symfony console
run psql                        # connects psql to your database using containers
run project                     # alias for `docker-compose -p app up -d`
run composer                    # alias for running composer (with php7 in separate docker container)
run phpspec                     # alias for running PhpSpec
run behat                       # alias for running Behat in test environment
```

## Development

To start dev environment, first you need to install project dependencies via composer. You could use your local composer or by running `run composer install --ignore-platform-reqs` command.

After this, just run `docker-compose up` and you are ready to go.

### Testing

To run test suites you can use `support/scripts/run_tests` script, or use phpspec/behat separately (see aliases section).

### XDebug

This projects template also includes xdebug extensions for remote debugging. To debug your application in PhpStorm you should configure remote server and []set path mapping](https://www.jetbrains.com/phpstorm/help/override-server-path-mappings-dialog.html) to `/srv` directory.

In production environment xdebug is disabled.

## Deployment

**Note**: This section doesn't cover config section yet

 - Add your remote host as docker machine:

```
docker-machine create --driver general --general-ip "$YOUR_REMOTE_HOST" your_host_name
```

 - Connect docker client to remote docker demon:

```
eval "$(docker-machine env your_host_name)"
```

 - Run `docker-compose up -d` and that all!


