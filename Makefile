FILE := ./srcs/docker-compose.yml
COMP := docker-compose
DIR_WP := /home/ecaliska/data/wordpress
DIR_MDB := /home/ecaliska/data/mariadb
DATA := /home/ecaliska/data

all: compose

compose:
	@if [ -d "$(DIR_WP)" ]; then \
		echo "Directory $(DIR_WP) exists\nDoing nothing."; \
	else \
		echo "directory $(DIR_WP) doesn't exist."; \
		echo "Generating file..."; \
		mkdir -p $(DIR_WP); \
		echo "Giving ownership..."; \
		chown -R 1000:1000 $(DIR_WP); \
		echo "Giving permissions..."; \
		chmod -R 755 $(DIR_WP); \
	fi
	@if [ -d "$(DIR_MDB)" ]; then \
		echo "Directory $(DIR_MDB) exists\nDoing nothing."; \
	else \
		echo "directory $(DIR_MDB) doesn't exist."; \
		echo "Generating file..."; \
		mkdir -p $(DIR_MDB); \
		echo "Giving ownership..."; \
		chown -R 1000:1000 $(DIR_MDB); \
		echo "Giving permissions..."; \
		chmod -R 755 $(DIR_MDB); \
	fi
	$(COMP) -f $(FILE) up --build

down:
	$(COMP) -f $(FILE) down

fclean: down
	sudo rm -rf $(DATA)
	docker system prune --volumes -af
	sudo systemctl stop nginx

re: fclean all

