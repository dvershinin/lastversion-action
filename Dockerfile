# Use your existing Docker image as the base image
FROM ghcr.io/dvershinin/lastversion:latest

# Using "lastversion" user as provided by some linter was a mistake and causes issues with GitHub actions being ran as "runner"
# and lastversion running as a different user and being unable to work with workspace files for extracting to its directory
USER root

# Copy the entrypoint.sh script into the container
COPY entrypoint.sh /entrypoint.sh

# Set the entrypoint script as the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
