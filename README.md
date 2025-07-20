# Concert Data - n8n Workflow Automation

This project provides an n8n workflow automation platform running in Docker for managing concert-related data and automations.

## Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Git installed

### Setup

1. Clone this repository:
```bash
git clone https://github.com/yourusername/concert-data.git
cd concert-data
```

2. Start n8n:
```bash
docker-compose up -d
```

3. Access n8n at http://localhost:5678

### First Time Setup

When you first access n8n, you'll need to:
1. Create an admin account
2. Set up your first workflow

## Configuration

### Environment Variables

The `.env` file contains configuration options:

- `N8N_HOST`: Host for n8n (default: localhost)
- `N8N_PROTOCOL`: Protocol (http/https, default: http)
- `WEBHOOK_URL`: Base URL for webhooks
- `TIMEZONE`: Timezone for n8n (default: Europe/Berlin)

### Data Persistence

n8n data is persisted in a Docker volume named `n8n_data`. This includes:
- Workflow definitions
- Execution history
- Credentials (encrypted)
- Settings

## Usage

### Start the service
```bash
docker-compose up -d
```

### Stop the service
```bash
docker-compose down
```

### View logs
```bash
docker-compose logs -f n8n
```

### Update n8n
```bash
docker-compose pull
docker-compose up -d
```

## Project Structure

```
concert-data/
├── docker-compose.yml  # Docker configuration
├── .env               # Environment variables
├── .gitignore         # Git ignore rules
└── README.md          # This file
```

## Security Notes

- For production use, set `N8N_ENCRYPTION_KEY` and `N8N_USER_MANAGEMENT_JWT_SECRET`
- Consider using HTTPS in production
- Restrict access to port 5678 in production environments

## License

MIT License