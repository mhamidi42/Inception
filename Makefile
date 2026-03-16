# **************************************************************************** #
#                                   COLORS                                     #
# **************************************************************************** #

GREEN = \033[0;32m
YELLOW = \033[0;33m
RED = \033[0;31m
RESET = \033[0m

# **************************************************************************** #
#                                 VARIABLES                                    #
# **************************************************************************** #

DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml
VOLUME_PATH = /home/$(USER)/data

# **************************************************************************** #
#                                   RULES                                      #
# **************************************************************************** #

all: up

up:
	@echo "$(GREEN)🚀 Building and starting Inception containers...$(RESET)"
	@sudo mkdir -p $(VOLUME_PATH)/mariadb
	@sudo mkdir -p $(VOLUME_PATH)/wordpress
	@$(DOCKER_COMPOSE) up --build -d

down:
	@echo "$(YELLOW)🧹 Stopping containers...$(RESET)"
	@$(DOCKER_COMPOSE) down

clean: down
	@echo "$(RED)🗑️ Removing containers, images and volumes...$(RESET)"
	@$(DOCKER_COMPOSE) down -v --rmi all

fclean: clean
	@echo "$(RED)🔥 Deleting all Docker data (volumes, networks)...$(RESET)"
	@sudo rm -rf $(VOLUME_PATH)

re: fclean all

ps:
	@$(DOCKER_COMPOSE) ps

logs:
	@$(DOCKER_COMPOSE) logs -f

# **************************************************************************** #
#                                   HELP                                       #
# **************************************************************************** #

help:
	@echo "$(YELLOW)Available commands:$(RESET)"
	@echo "  $(GREEN)make$(RESET) or $(GREEN)make all$(RESET)    → Build and start containers"
	@echo "  $(GREEN)make down$(RESET)           → Stop containers"
	@echo "  $(GREEN)make clean$(RESET)          → Remove containers, images, and volumes"
	@echo "  $(GREEN)make fclean$(RESET)         → Full clean (also removes /home/$(USER)/data)"
	@echo "  $(GREEN)make re$(RESET)             → Rebuild everything"
	@echo "  $(GREEN)make ps$(RESET)             → Show running containers"
	@echo "  $(GREEN)make logs$(RESET)           → Show live logs"

