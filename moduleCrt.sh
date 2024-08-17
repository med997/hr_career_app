#!/bin/bash

# Check if a parent directory is provided as an argument
if [ -z "$1" ]; then
  echo "Error: Please provide a parent directory as an argument."
  exit 1
fi

# Set the parent directory from the argument
parent_dir="$1"
# shellcheck disable=SC2164
cd /Users/mohammed/hr_career_platform/lib/features
# Create directories on both Windows and Mac
mkdir -p "$parent_dir"/{data,domain,presentation}
mkdir -p "$parent_dir"/data/{datasources,repositories,models}
mkdir -p "$parent_dir"/domain/{entities,repositories,usecases}
mkdir -p "$parent_dir"/presentation/{ui,widgets,bloc}

# Create files on both Windows and Mac
touch "$parent_dir"/data/datasources/"${parent_dir}_remote_datasource.dart"
touch "$parent_dir"/data/datasources/"${parent_dir}_local_datasource.dart"
touch "$parent_dir"/data/models/"${parent_dir}_model.dart"
touch "$parent_dir"/data/repositories/"${parent_dir}_repository_impl.dart"

touch "$parent_dir"/domain/repositories/"${parent_dir}_repository.dart"
touch "$parent_dir"/domain/entities/"${parent_dir}.dart"
touch "$parent_dir"/domain/usecases/"add_${parent_dir}.dart"
touch "$parent_dir"/domain/usecases/"fetch_${parent_dir}.dart"
touch "$parent_dir"/domain/usecases/"update_${parent_dir}.dart"
touch "$parent_dir"/domain/usecases/"delete_${parent_dir}.dart"

echo "Project structure created successfully in '$parent_dir' directory."