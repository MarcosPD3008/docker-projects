# Docker Projects

This repository is a collection of Docker Compose configurations to manage and deploy various applications efficiently. It serves as a central place to store and share Docker Compose files for personal use or collaborative projects.

## Contents

- **n8n**: Workflow automation platform with PostgreSQL and Redis backend for scalable automation workflows
- **Nextcloud**: Configuration to deploy Nextcloud, a powerful and open-source file sharing and collaboration platform
- **SonarQube**: Configuration for deploying SonarQube, a platform for continuous inspection of code quality
- **Wiki**: Configuration for setting up a Wiki platform, providing a space for documentation and collaboration

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

## Quick Start

Navigate to the respective service directory and run:
```bash
docker-compose up -d
```

### Access URLs
- n8n: http://localhost:5678
- Nextcloud: http://localhost:8081 (HTTP) or https://localhost:8443 (HTTPS)
- SonarQube: http://localhost:9000
- Wiki.js: http://localhost:3000

## Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+

## Network Configuration

Each service uses its own Docker network for isolation and security. Services within the same compose file can communicate using service names as hostnames.

## GitHub Actions CI/CD

This repository includes automated deployment workflows that detect changes to docker-compose files and deploy only the updated services using GitHub self-hosted runners.

### Available Workflows

1. **Local Development** (`.github/workflows/deploy-local.yml`)
   - Triggers on: Push to `develop` branch or `feature/*` branches
   - Also supports manual dispatch with service selection
   - Validates and deploys services locally in GitHub hosted runners

2. **Self-Hosted Production** (`.github/workflows/deploy-remote.yml`)
   - Triggers on: Push to `main`/`master` branch
   - Deploys directly on your server using self-hosted runners
   - Includes health checks and automatic cleanup

3. **Multi-Environment Deploy** (`.github/workflows/deploy-labeled.yml`)
   - Supports multiple environments (production, staging, development)
   - Uses runner labels to target specific servers
   - Includes backup/rollback functionality
   - Manual dispatch with environment selection

4. **Basic Service Deploy** (`.github/workflows/deploy-services.yml`)
   - Simple workflow for basic parallel deployments

### Setup for Self-Hosted Runners

1. **Install GitHub Runner on your server:**
   ```bash
   # Download and configure the runner
   mkdir actions-runner && cd actions-runner
   curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz
   tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz
   
   # Configure (use your repo URL and token from GitHub Settings)
   ./config.sh --url https://github.com/YOUR_USERNAME/YOUR_REPO --token YOUR_TOKEN
   
   # Install as service
   sudo ./svc.sh install
   sudo ./svc.sh start
   ```

2. **For multiple environments, add labels:**
   ```bash
   # Production server
   ./config.sh --url https://github.com/YOUR_USERNAME/YOUR_REPO --token YOUR_TOKEN --labels production
   
   # Staging server  
   ./config.sh --url https://github.com/YOUR_USERNAME/YOUR_REPO --token YOUR_TOKEN --labels staging
   ```

3. **Ensure Docker is installed and accessible:**
   ```bash
   # Add runner user to docker group
   sudo usermod -aG docker actions-runner
   ```

### Manual Deployment

You can manually trigger deployments from the GitHub Actions tab:
- **Local Development Deploy** → Run workflow → Select service
- **Multi-Environment Deploy** → Run workflow → Select environment

### How it Works

The workflows use path filtering to detect which docker-compose files changed:
- Changes to `n8n/` folder → deploys only n8n
- Changes to `nextcloud/` folder → deploys only Nextcloud  
- Changes to `sonarqube/` folder → deploys only SonarQube
- Changes to `wiki/` folder → deploys only Wiki

### Benefits of Self-Hosted Runners

✅ **No SSH setup required** - Runners communicate directly with GitHub
✅ **Faster deployments** - Direct local access to Docker
✅ **Better security** - No need to store SSH keys  
✅ **Environment isolation** - Use labels to target specific servers
✅ **Automatic cleanup** - Built-in Docker image pruning
✅ **Backup & rollback** - Automatic configuration backups

This ensures efficient deployments with zero downtime and proper error handling.
