# Use your existing Docker image as the base image
FROM ghcr.io/dvershinin/lastversion:latest

# Copy the entrypoint.sh script into the container
COPY entrypoint.sh /entrypoint.sh

# Set the entrypoint script as the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
