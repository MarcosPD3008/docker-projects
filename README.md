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

## GitHub Actions Automated Deployment

This repository includes automated deployment workflows using a self-hosted GitHub runner that deploys services directly to your server.

### Available Workflow

**Docker Services Deploy** (`.github/workflows/deploy-services.yml`)
- **Push to main/master**: Validates and automatically deploys changed services
- **Pull Requests**: Validates configurations only (no deployment)
- Uses modern `docker compose` commands
- Includes health checks and automatic cleanup

### How it Works

The workflow automatically detects and deploys only the services that changed:
- Changes to `n8n/` folder → validates and deploys n8n
- Changes to `nextcloud/` folder → validates and deploys Nextcloud  
- Changes to `sonarqube/` folder → validates and deploys SonarQube
- Changes to `wiki/` folder → validates and deploys Wiki
- Changes to `minecraft/` folder → validates and deploys Minecraft

### Deployment Process

When you push changes to the main branch:

1. **🔍 Detection**: Identifies which services changed
2. **📋 Validation**: Validates docker-compose syntax
3. **🚀 Deployment**: Runs on your self-hosted runner:
   - Stops existing containers
   - Pulls latest images
   - Starts updated services
4. **🩺 Health Check**: Verifies services are running
5. **🧹 Cleanup**: Removes unused Docker images

### Manual Deployment (Alternative)

You can still manually deploy if needed:

```bash
# Navigate to the service directory
cd n8n  # or nextcloud, sonarqube, wiki, minecraft

# Deploy the service
docker compose up -d

# Check status
docker compose ps
```

### Benefits

- ✅ **Automatic deployment** - Push to main and services deploy automatically
- ✅ **Selective deployment** - Only changed services are redeployed
- ✅ **Validation first** - Configurations are validated before deployment
- ✅ **Health checks** - Ensures services start successfully
- ✅ **Self-hosted** - Runs directly on your server
- ✅ **Modern commands** - Uses `docker compose` (not deprecated `docker-compose`)
