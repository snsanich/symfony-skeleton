General Backend Template Project
===================================

**If you need Vagrant + Ansible version, please check [vagrant_ansible](https://github.com/intellectsoft-uk/symfony-skeleton/tree/vagrant_ansible) branch.**

## What's included

This is our day-to-day backend dev stack

 - Pre-configured PHP 7 FPM and CLI
 - Pre-configured Nginx 1.9
 - PostgreSQL 9.4
 - Symfony 2.8 standard edition
 - Doctrine ORM 2.5
 - FosRestBundle
 - Behat and PhpSpec as testing frameworks

This skeleton includes several optimizations:

 - Enabled APCu cache for Doctrine and Validator (currently this isn't true since apcu isn't available for php7 right now)

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

## Development

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


