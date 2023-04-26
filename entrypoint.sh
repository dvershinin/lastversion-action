#!/bin/sh -l
set -x
# Initialize variables
format=""
action=""
repository=""
branch=""
github_token=""

# Parse the named arguments
while [ "$#" -gt 0 ]; do
  case "$1" in
    --format)
      format="$2"
      shift 2
      ;;
    --action)
      action="$2"
      shift 2
      ;;
    --branch)
      branch="$2"
      shift 2
      ;;
    --repository)
      repository="$2"
      shift 2
      ;;
    --github_token)
      github_token="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
done

# Set the GITHUB_TOKEN environment variable
export GITHUB_TOKEN="$github_token"

# Run the lastversion command with the given inputs
if [ -z "$branch" ]; then
  result=$(lastversion --format "$format" "$action" "$repository")
else
  result=$(lastversion --branch "$branch" --format "$format" "$action" "$repository")
fi

# Set the result as an output variable
echo "last_version=${result}" >> "$GITHUB_OUTPUT"
