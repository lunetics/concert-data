.PHONY: help install-mkcert install-cert up down restart logs clean status

# Default target
help:
	@echo "Available commands:"
	@echo "  install-mkcert    Install mkcert if not already installed"
	@echo "  install-cert      Generate SSL certificates for concert-data.test"
	@echo "  up                Start all services"
	@echo "  down              Stop all services"
	@echo "  restart           Restart all services"
	@echo "  logs              Show logs for all services"
	@echo "  status            Show status of all services"
	@echo "  clean             Stop services and remove certificates"

# Install mkcert
install-mkcert:
	@echo "Checking for mkcert installation..."
	@if ! command -v mkcert >/dev/null 2>&1; then \
		echo "Installing mkcert..."; \
		if command -v brew >/dev/null 2>&1; then \
			brew install mkcert; \
		elif command -v apt >/dev/null 2>&1; then \
			sudo apt update && sudo apt install -y mkcert; \
		elif command -v yum >/dev/null 2>&1; then \
			sudo yum install -y mkcert; \
		elif command -v pacman >/dev/null 2>&1; then \
			sudo pacman -S mkcert; \
		else \
			echo "Please install mkcert manually: https://github.com/FiloSottile/mkcert#installation"; \
			exit 1; \
		fi; \
	else \
		echo "mkcert is already installed"; \
	fi

# Generate SSL certificates
install-cert: install-mkcert
	@echo "Installing mkcert CA..."
	@mkcert -install
	@echo "Generating SSL certificate for concert-data.test..."
	@mkdir -p ssl
	@cd ssl && mkcert concert-data.test
	@echo "SSL certificates generated successfully!"
	@echo "Location: ./ssl/"
	@ls -la ssl/

# Start services
up: install-cert
	@echo "Starting services..."
	@docker-compose up -d
	@echo "Services started!"
	@echo "Access n8n at: https://concert-data.test"

# Stop services
down:
	@echo "Stopping services..."
	@docker-compose down
	@echo "Services stopped!"

# Restart services
restart:
	@echo "Restarting services..."
	@docker-compose restart
	@echo "Services restarted!"

# Show logs
logs:
	@docker-compose logs -f

# Show status
status:
	@docker-compose ps

# Clean up
clean: down
	@echo "Cleaning up..."
	@rm -rf ssl/
	@docker-compose down -v
	@echo "Cleanup complete!"