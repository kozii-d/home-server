#!/usr/bin/make

include .env

## ------[ ACTIONS ]---------
up:
	docker compose up -d

down:
	docker compose down

restart: down up

help:
	@echo "\033[1mAvailable commands:\033[0m"
	@echo "  \033[1;34mup\033[0m            			Start all containers"
	@echo "  \033[1;34mdown\033[0m          			Stop all containers"
	@echo "  \033[1;34mrestart\033[0m       			Restart all containers"
	@echo "  \033[1;34mhelp\033[0m          			Show this help"
