#!/bin/sh -l

# Parse inputs from the GitHub action
repository="$1"
branch="$2"

# Set the GITHUB_TOKEN environment variable
export GITHUB_TOKEN="$3"

# Run the lastversion command with the given inputs
if [ -z "$branch" ]; then
  result=$(lastversion "$repository")
else
  result=$(lastversion "$repository" --branch "$branch")
fi

# Set the result as an output variable
echo "last_version=${result}" >> "$GITHUB_OUTPUT"
