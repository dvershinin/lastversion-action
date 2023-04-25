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

# Print the result and set it as an output variable
echo "Last version: $result"
echo "::set-output name=last_version::$result"
