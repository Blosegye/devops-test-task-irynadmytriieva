#!/bin/bash

# Create a directory for the output if do not exist
mkdir -p output

# Set current date
current_date=$(date +%Y%m%d_%H%M%S)

# Greetings function
greetings () {
    echo "Hello from Bash!"
}
# Count the number of files in the output directory, excluding subdirectories function
count_files() {
    find ./output/ -maxdepth 1 -type f | wc -l 
}

# initialize the env var for log file count
log_count_files(){
    echo "LOG_FILE_COUNT=$(count_files)" >> "$GITHUB_ENV"
}
# call the function
log_count_files

# initialization for the file 
if [[ -n "$1" ]]; then
    output_file="$1"
else 
    output_file="log-${current_date}.txt"
fi

# initialize the env var for log file name
log_file() {
    echo "LOG_FILE=${output_file}" >> "$GITHUB_ENV"
}
# call the function
log_file


# Redirect output to a file including errors
exec > output/$output_file 2>&1

# providing the data to the document
greetings
echo "Current date and time: $current_date"
echo "Number of files: $(count_files)"

