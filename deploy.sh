#!/bin/bash

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Starting deployment...${NC}"

# Optional: specify versions as arguments
API_VERSION=${1:-main}
CLIENT_VERSION=${2:-main}

echo -e "${GREEN}API Version: $API_VERSION${NC}"
echo -e "${GREEN}Client Version: $CLIENT_VERSION${NC}"

# Export versions for docker-compose
export API_VERSION
export CLIENT_VERSION

# Pull latest images
echo -e "${BLUE}Pulling images...${NC}"
docker-compose pull

# Stop and remove old containers
echo -e "${BLUE}Stopping old containers...${NC}"
docker-compose down

# Start services
echo -e "${BLUE}Starting services...${NC}"
docker-compose up -d

# Wait for health checks
echo -e "${BLUE}Waiting for services to be healthy...${NC}"
sleep 5

# Show status
echo -e "${GREEN}Deployment complete!${NC}"
docker-compose ps

# Show logs
echo -e "${BLUE}Recent logs:${NC}"
docker-compose logs --tail=20