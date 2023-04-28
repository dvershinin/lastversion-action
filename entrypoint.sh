#!/bin/sh -l

# Initialize variables
format=""
action=""
repository=""
branch=""
extra_args=""
github_token=""
working_directory=""

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
    --extra_args)
      extra_args="$2"
      shift 2
      ;;
    # other arguments ...
    --github_token)
      github_token="$2"
      shift 2
      ;;
    --working_directory)
      working_directory="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
done

echo "Current repo: $GITHUB_REPOSITORY"

# Set the GITHUB_TOKEN environment variable
export GITHUB_TOKEN="$github_token"

cd $working_directory

# Run the lastversion command with the given inputs
if [ -z "$branch" ]; then
  result=$(lastversion $extra_args --format "$format" "$action" "$repository")
else
  result=$(lastversion $extra_args --branch "$branch" --format "$format" "$action" "$repository")
fi

# Set the result as an output variable
echo "last_version=${result}" >> "$GITHUB_OUTPUT"
