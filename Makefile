NAME = inception

MKDIR = mkdir -p

SRC = srcs
ENV = $(SRC)/.env
include $(ENV)
DOCKER = docker compose --project-directory $(SRC) --env-file $(ENV) -p $(NAME)

N = nginx
W = wordpress
DB = mariadb
A = adminer

.PHONY: all clean fclean re stop down ps n wp db a logn logw logdb logs loga dir buildn buildwp builddb prune

$(NAME):
	$(DOCKER) up -d

all: dir builddb buildwp buildn $(NAME)

dir:
	$(MKDIR) $(VOLUME_DIR)
	$(MKDIR) $(VOLUME_WP)
	$(MKDIR) $(VOLUME_DB)

stop:
	$(DOCKER) stop

down:
	$(DOCKER) down

clean: stop

ps:
	$(DOCKER) ps -a

n:
	$(DOCKER) exec -it $(N) /bin/bash

wp:
	$(DOCKER) exec -it $(W) /bin/bash

db:
	$(DOCKER) exec -it $(DB) /bin/bash

#a:
#	$(DOCKER) exec -it $(A) /bin/bash

buildn:
	docker build -t $(N) srcs/requirements/nginx

buildwp:
	docker build -t $(W) srcs/requirements/wordpress

builddb:
	docker build -t $(DB) srcs/requirements/mariadb

logn:
	$(DOCKER) logs -f $(N)

logw:
	$(DOCKER) logs -f $(W)

logdb:
	$(DOCKER) logs -f $(DB)

logs:
	$(DOCKER) logs -f

#loga:
#	$(DOCKER) logs -f $(A)

prune:
	docker image prune -f

fclean: clean
	$(DOCKER) down --volumes
	sudo rm -rf $(VOLUME_DIR)

re: fclean all
