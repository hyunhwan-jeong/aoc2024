import * as fs from 'fs';
import * as readline from 'readline';

const regex = /mul\((\d+),(\d+)\)/g; // Regex to match patterns like mul(num1,num2)

const matches: { num1: number; num2: number }[] = [];



console.log(matches);


const filePath = "input.txt"
const fileStream = fs.createReadStream(filePath);

const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
})

let board: number[][] = [];

let answer = 0;
rl.on("line", (line) => {
    let match: RegExpExecArray | null;
    while ((match = regex.exec(line)) !== null) {
        const num1 = parseInt(match[1], 10); // Extract num1 and convert to number
        const num2 = parseInt(match[2], 10); // Extract num2 and convert to number
        answer += num1 * num2;
        console.log("parsed", num1, num2);
    }
})

rl.on("close", () => {
    console.log(answer)
});

