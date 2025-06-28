# Docker Projects

This repository is a collection of Docker Compose configurations to manage and deploy various applications efficiently. It serves as a central place to store and share Docker Compose files for personal use or collaborative projects.

## Contents

- **n8n**: Workflow automation platform with PostgreSQL and Redis backend for scalable automation workflows
- **Nextcloud**: Configuration to deploy Nextcloud, a powerful and open-source file sharing and collaboration platform
- **SonarQube**: Configuration for deploying SonarQube, a platform for continuous inspection of code quality
- **Wiki**: Configuration for setting up a Wiki platform, providing a space for documentation and collaboration
- **Minecraft**: Modded Minecraft server using Forge for multiplayer gaming

## Services Overview

### n8n (Workflow Automation)
- **Location**: `n8n/docker-compose.yml`
- **Services**: n8n, PostgreSQL 15, Redis 7
- **Ports**: 
  - n8n Web UI: `5678`
  - Redis: `6379`
- **Features**: 
  - PostgreSQL database backend for workflow persistence
  - Redis for caching and queue management
  - Timezone configured for America/Santo_Domingo
  - Persistent data volumes for database and n8n configuration

### Nextcloud
- **Location**: `nextcloud/docker-compose.yml`
- **Services**: Nextcloud, MariaDB
- **Ports**: 
  - HTTP: `8081`
  - HTTPS: `8443`
- **Features**:
  - MariaDB database backend
  - Persistent storage for files and configuration
  - Timezone configured for America/Los_Angeles

### SonarQube
- **Location**: `sonarqube/docker-compose.yml`
- **Services**: SonarQube Community, PostgreSQL 13
- **Ports**: 
  - Web UI: `9000`
- **Features**:
  - PostgreSQL database backend
  - Code quality and security analysis
  - Persistent data volumes

### Wiki (Wiki.js)
- **Location**: `wiki/docker-compose.yml`
- **Services**: Wiki.js, PostgreSQL 13
- **Ports**: 
  - Web UI: `3000`
- **Features**:
  - PostgreSQL database backend
  - Modern documentation platform
  - Persistent data storage

### Minecraft Server
- **Location**: `minecraft/docker-compose.yml`
- **Services**: Minecraft Forge Server
- **Ports**: 
  - Game Server: `25565`
- **Features**:
  - Minecraft Forge 1.20.1 with Forge version 47.1.3
  - 10GB RAM allocation for smooth gameplay
  - Persistent world data storage
  - EULA automatically accepted
  - Support for mods (place in `./data/mods` directory)

## Quick Start

Navigate to the respective service directory and run:
```bash
docker compose up -d
```

### Access URLs
- n8n: http://localhost:5678
- Nextcloud: http://localhost:8081 (HTTP) or https://localhost:8443 (HTTPS)
- SonarQube: http://localhost:9000
- Wiki.js: http://localhost:3000
- Minecraft Server: `localhost:25565` (connect from Minecraft client)

## Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+

## Network Configuration

Each service uses its own Docker network for isolation and security. Services within the same compose file can communicate using service names as hostnames.

## GitHub Actions Validation

This repository includes a simple validation workflow that checks your docker-compose files for syntax errors and configuration issues.

### Available Workflow

**Docker Compose Validation** (`.github/workflows/deploy-services.yml`)
- Triggers on: Push to `main`/`master` branch or pull requests
- Validates docker-compose syntax using `docker compose config`
- Only checks files that have changed
- Provides a summary of validation results

### How it Works

The workflow uses path filtering to detect which docker-compose files changed:
- Changes to `n8n/` folder → validates n8n configuration
- Changes to `nextcloud/` folder → validates Nextcloud configuration  
- Changes to `sonarqube/` folder → validates SonarQube configuration
- Changes to `wiki/` folder → validates Wiki configuration
- Changes to `minecraft/` folder → validates Minecraft configuration

### Manual Deployment

Since you run services directly on your server, after the validation passes, you can manually deploy:

```bash
# Navigate to the service directory
cd n8n  # or nextcloud, sonarqube, wiki, minecraft

# Deploy the service
docker compose up -d

# Check status
docker compose ps
```

This approach gives you:
- ✅ **Configuration validation** - Catch syntax errors before deploying
- ✅ **Simple workflow** - No complex deployment automation
- ✅ **Manual control** - You decide when and how to deploy
- ✅ **Local network access** - Services accessible on your local network
