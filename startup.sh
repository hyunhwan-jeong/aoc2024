#!/bin/bash

# Check if folder name is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <folder_name>"
    exit 1
fi

# Step 1: Create the folder
FOLDER_NAME=$1
mkdir -p "$FOLDER_NAME"
echo "Folder '$FOLDER_NAME' created."

# TypeScript file content
FILE_CONTENT='import * as fs from \'fs\';
import * as readline from \'readline\';

const filePath = "input.txt";
const fileStream = fs.createReadStream(filePath);

const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
});

let answer = 0;
rl.on("line", (line) => {

});

rl.on("close", () => {    
    console.log(answer);
});
'

# Step 2: Create P1.ts and P2.ts with the provided content
echo "$FILE_CONTENT" > "$FOLDER_NAME/P1.ts"
echo "$FILE_CONTENT" > "$FOLDER_NAME/P2.ts"
echo "Files 'P1.ts' and 'P2.ts' created in folder '$FOLDER_NAME'."

# Step 3: Create an empty input.txt
touch "$FOLDER_NAME/input.txt"
echo "Empty 'input.txt' file created in folder '$FOLDER_NAME'."