project_name = "example"
current_dir = $(shell pwd)

.PHONY: build install

build: install

	@echo Build images...
	docker-compose -p $(project_name) -f devops/docker-compose.build.yml build

install:
	@echo Install dependencies
	docker run --rm -v $(current_dir):/app composer/composer install
