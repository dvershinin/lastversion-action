# Use your existing Docker image as the base image
FROM ghcr.io/dvershinin/lastversion:latest

# Create a group and user with matching GID and UID
RUN addgroup -g 127 runner \
    && adduser -u 1001 -G runner -D runner

# Switch to the matching user
USER runner

# Copy the entrypoint.sh script into the container
COPY entrypoint.sh /entrypoint.sh

# Set the entrypoint script as the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
