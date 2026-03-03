.PHONY: build rebuild stop logs ps help

# Build and start all services
build:
	docker compose up --build -d

# Force rebuild from scratch (no cache) and restart
rebuild:
	docker compose down
	docker compose build --no-cache
	docker compose up -d

# Stop one or several apps: make stop APP="vite-app mavproxy"
# Stop all if no APP specified: make stop
stop:
	ifdef APP
		docker compose stop $(APP)
	else
		docker compose down
	endif

# Useful extras
logs:
	ifdef APP
		docker compose logs -f $(APP)
	else
		docker compose logs -f
	endif

ps:
	docker compose ps

help:
	@echo "Usage:"
	@echo "  make build                        - Build and start all services"
	@echo "  make rebuild                      - Full rebuild (no cache) and restart"
	@echo "  make stop                         - Stop and remove all containers"
	@echo "  make stop APP=\"vite-app\"          - Stop one service"
	@echo "  make stop APP=\"vite-app mavproxy\" - Stop several services"
	@echo "  make logs                         - Follow logs for all services"
	@echo "  make logs APP=\"ai-app\"            - Follow logs for one service"
	@echo "  make ps                           - Show running containers"