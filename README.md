General Backend Template Project
===================================

## What's included

This is our day-to-day backend dev stack

 - Pre-configured PHP 7 FPM and CLI
 - Pre-configured Nginx 1.9
 - PostgreSQL 9.4
 - Symfony 2.7 standard edition (without assetic)
 - Doctrine ORM 2.5
 - FosRestBundle

This skeleton includes several optimizations:

 - Enabled APCu cache for Doctrine and Validator (currently this isn't true since apcu isn't available for php7 right now)

## Required software

 - Docker 1.8+
 - Docker-compose 1.5+
 - Ansible2 (for deployment only)

### Docker

All environment isolated from host system via Docker containers.

For understanding of how Docker works please read this articles:

 - [About Docker](http://www.wintellect.com/devcenter/paulballard/what-developers-need-to-know-about-docker)
 - [Visualizing Docker Containers and Images](http://merrigrove.blogspot.com.by/2015/10/visualizing-docker-containers-and-images.html)
 - [Data-only containers madness](http://container42.com/2014/11/18/data-only-container-madness/)
 - [Docker Documentation](https://docs.docker.com/engine/misc/)
 - [Docker Compose Documentation](https://docs.docker.com/compose/)

### For MAC OSX users

To run Docker images you should have linux kernel. This could be a tiny problem for Mac OSX users. We recommend to use [docker-machine](https://docs.docker.com/v1.8/installation/mac/) or [dinghy](https://github.com/codekitchen/dinghy).

## Deployment

TODO
