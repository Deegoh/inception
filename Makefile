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

.PHONY: all clean fclean re stop down ps n wp db a logn logw logdb loga dir buildn prune

all: dir $(NAME)

dir:
	$(MKDIR) $(VOLUME_DIR)
	$(MKDIR) $(VOLUME_WP)
	$(MKDIR) $(VOLUME_DB)
	#$(MKDIR) $(NGINX_DIR)
	#$(MKDIR) $(NGINX_SSL)
	#$(MKDIR) $(NGINX_CONF)

$(NAME):
	$(DOCKER) up -d

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

a:
	$(DOCKER) exec -it $(A) /bin/bash

buildn:
	docker build -t inception_nginx srcs/requirements/nginx
	#docker run -dp 8080:80 inception_nginx nginx -g 'daemon off;'

buildwp:
	#docker rm inception_wp
	docker build -t inception_wp srcs/requirements/wordpress
#	docker run --name inception_wp --env-file=srcs/.env -dp 9000:9000 inception_wp sleep infinity
#	docker exec -it inception_wp /bin/bash

logn:
	$(DOCKER) logs -f $(N)

logw:
	$(DOCKER) logs -f $(W)

logdb:
	$(DOCKER) logs -f $(DB)

loga:
	$(DOCKER) logs -f $(A)

prune:
	docker image prune -f

fclean: clean
	$(DOCKER) down --volumes
	rm -rf $(VOLUME_DIR)

re: fclean all
