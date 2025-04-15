#!/usr/bin/make

include .env

## ------[ ENV ] ------
COMPOSE_CONFIG=--env-file .env

## ------[ ACTIONS ]---------
up:
	docker compose $(COMPOSE_CONFIG) up -d

down:
	docker compose $(COMPOSE_CONFIG) down

restart: down up

#localCerts:
#	@echo "\033[1;32mGenerating local certificates for ${LOCAL_DOMAIN:-local.domain}...\033[0m"
#	docker compose $(COMPOSE_CONFIG) -f mkcert/docker-compose.mkcert.yml run --rm --build mkcert
#	@echo "\033[1;32mCertificates generated successfully!\033[0m"
#	@echo "\033[1;33mDon't forget to install rootCA.pem on your client devices\033[0m"

localCerts:
	@echo "\033[1;32mGenerating local certificates for ${LOCAL_DOMAIN}...\033[0m"
	docker compose $(COMPOSE_CONFIG) -f mkcert/docker-compose.mkcert.yml run --rm --build mkcert
	@echo "\033[1;32mCopying certificates and configuration...\033[0m"
	@mkdir -p traefik/localCerts
	@mkdir -p traefik/dynamic
	@if [ -d "mkcert/data/localCerts" ]; then \
		mv mkcert/data/localCerts/* traefik/localCerts/; \
		echo "\033[1;32mCertificates moved successfully!\033[0m"; \
	fi
	@if [ -f "mkcert/data/local-tls.yml" ]; then \
		mv mkcert/data/local-tls.yml traefik/dynamic/local-tls.yml; \
		echo "\033[1;32mTLS configuration moved successfully!\033[0m"; \
	fi
	@echo "\033[1;32mCertificates generated successfully!\033[0m"
	@echo "\033[1;33mDon't forget to install rootCA.pem on your client devices\033[0m"

help:
	@echo "\033[1mAvailable commands:\033[0m"
	@echo "  \033[1;34mup\033[0m            			Start all containers"
	@echo "  \033[1;34mdown\033[0m          			Stop all containers"
	@echo "  \033[1;34mrestart\033[0m       			Restart all containers"
	@echo "  \033[1;34mcerts\033[0m                                 Generate local certificates"
	@echo "  \033[1;34mhelp\033[0m          			Show this help"
