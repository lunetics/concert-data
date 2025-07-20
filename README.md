# Concert Data - n8n Workflow Automation

This project provides an n8n workflow automation platform running in Docker for managing concert-related data and automations.

## Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Git installed
- Make (for easy management)

### Setup

1. Clone this repository:
```bash
git clone https://github.com/yourusername/concert-data.git
cd concert-data
```

2. Start n8n with HTTPS:
```bash
make up
```

This will:
- Install mkcert if needed
- Generate SSL certificates
- Start nginx and n8n services
- Configure HTTPS automatically

3. Access n8n at https://concert-data.test

### Manual Setup (Alternative)

If you prefer manual setup:

1. Install mkcert and generate certificates:
```bash
make install-cert
```

2. Start services:
```bash
docker-compose up -d
```

### First Time Setup

When you first access n8n, you'll need to:
1. Create an admin account
2. Set up your first workflow

## Make Commands

This project includes a Makefile for easy management:

```bash
make help          # Show available commands
make up            # Start all services with HTTPS
make down          # Stop all services  
make restart       # Restart all services
make logs          # Show service logs
make status        # Show service status
make clean         # Stop services and remove certificates
```

### SSL Certificate Management

The project uses mkcert for trusted local HTTPS certificates:

- `make install-mkcert` - Install mkcert if not present
- `make install-cert` - Generate SSL certificates for concert-data.test

### Manual Hostname Setup (if needed)

If mkcert doesn't automatically configure your hosts file, add manually:

**Linux/macOS:**
```bash
echo "127.0.0.1 concert-data.test" | sudo tee -a /etc/hosts
```

**Windows:**
```cmd
echo 127.0.0.1 concert-data.test >> C:\Windows\System32\drivers\etc\hosts
```

## Configuration

### Environment Variables

The `.env` file contains configuration options:

- `N8N_HOST`: Host for n8n (default: concert-data.test)
- `N8N_PROTOCOL`: Protocol (http/https, default: https)
- `WEBHOOK_URL`: Base URL for webhooks (default: https://concert-data.test/)
- `TIMEZONE`: Timezone for n8n (default: Europe/Berlin)

### Data Persistence

n8n data is persisted in a Docker volume named `n8n_data`. This includes:
- Workflow definitions
- Execution history
- Credentials (encrypted)
- Settings

## Usage

### Start services
```bash
make up
```

### Stop services
```bash
make down
```

### View logs
```bash
make logs
```

### Check status
```bash
make status
```

### Update n8n
```bash
docker-compose pull
make restart
```

## Project Structure

```
concert-data/
├── docker-compose.yml  # Docker configuration with nginx + n8n
├── Makefile           # Management commands
├── .env               # Environment variables
├── .gitignore         # Git ignore rules
├── README.md          # This file
├── nginx/             # Nginx reverse proxy configuration
│   └── default.conf   # SSL/HTTPS configuration
└── ssl/               # Generated SSL certificates (ignored by git)
    ├── concert-data.test.pem
    └── concert-data.test-key.pem
```

## Security Notes

- HTTPS is enabled by default using mkcert for trusted local certificates
- For production use, set `N8N_ENCRYPTION_KEY` and `N8N_USER_MANAGEMENT_JWT_SECRET`
- Replace self-signed certificates with proper SSL certificates in production
- Restrict access to ports 80/443 in production environments
- The nginx configuration includes security headers for enhanced protection

## License

MIT License