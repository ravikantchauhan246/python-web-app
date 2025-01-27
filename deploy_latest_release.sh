#!/bin/bash

# Step 1: Get the latest release tag
LATEST_TAG=$(git describe --tags --abbrev=0)

if [ -z "$LATEST_TAG" ]; then
  echo "No release tags found. Exiting."
  exit 1
fi

echo "Latest release tag: $LATEST_TAG"

# Step 2: Checkout the latest release tag
git checkout "$LATEST_TAG"

# Step 3: Build the Docker image
echo "Building Docker image for tag: $LATEST_TAG"
docker build -t python-web-app:"$LATEST_TAG" .

if [ $? -ne 0 ]; then
  echo "Docker build failed. Exiting."
  exit 1
fi

# Step 4: Stop and remove any existing container with the same name
echo "Stopping and removing existing container (if any)..."
docker stop web-app || true
docker rm web-app || true

# Step 5: Deploy the Docker container
echo "Deploying Docker container for tag: $LATEST_TAG"
docker run -d -p 5000:5000 --name web-app python-web-app:"$LATEST_TAG"

if [ $? -eq 0 ]; then
  echo "Container deployed successfully!"
  echo "Access the app at http://localhost:5000/hello"
else
  echo "Container deployment failed."
  exit 1
fi