COMPOSE_FILE=srcs/docker-compose.yml

all: build up

build:
	@mkdir -p /home/kort/data/mariadb
	@mkdir -p /home/kort/data/wordpress
	@docker-compose -f $(COMPOSE_FILE) build

up:
	@docker-compose -f $(COMPOSE_FILE) up -d

down:
	@docker-compose -f $(COMPOSE_FILE) down

clean: down
	@docker volume rm inception_db_data inception_wp_files || true

fclean: clean
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker network rm inception_inception || true
	@sudo rm -rf /home/kort/data

re: fclean all

.PHONY: all build up down clean fclean re