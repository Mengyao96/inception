DATA_PATH = /home/mezhang/data

all: up

up:
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

stop:
	docker compose -f ./srcs/docker-compose.yml stop

start:
	docker compose -f ./srcs/docker-compose.yml start

logs:
	docker compose -f ./srcs/docker-compose.yml logs

fclean:down
	docker system prune -af
	sudo rm -rf $(DATA_PATH)

re:fclean up

.PHONY: all up down stop start logs fclean re
