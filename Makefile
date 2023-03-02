NAME = inception

SRC = srcs
ENV = $(SRC)/.env
DOCKER = docker compose --project-directory $(SRC) --env-file $(ENV) -p $(NAME)

.PHONY: all clean fclean re stop down

all: $(NAME)

$(NAME):
	$(DOCKER) up -d

stop:
	$(DOCKER) stop

down:
	$(DOCKER) down

clean: stop

fclean: clean
	$(DOCKER) down --volumes

re: fclean all
