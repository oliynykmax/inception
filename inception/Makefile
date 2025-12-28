COMPOSE_FILE	= srcs/docker-compose.yml
DATA_PATH		= /home/kort/data

all: build up

build:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@docker compose -f $(COMPOSE_FILE) build

up:
	@docker compose -f $(COMPOSE_FILE) up -d

down:
	@docker compose -f $(COMPOSE_FILE) down

clean: down
	@docker compose -f $(COMPOSE_FILE) down -v

fclean: clean
	@docker compose -f $(COMPOSE_FILE) down --rmi all --volumes
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@sudo rm -rf $(DATA_PATH)/wordpress/*

re: fclean all

.PHONY: all build up down clean fclean re
