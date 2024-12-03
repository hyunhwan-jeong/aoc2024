import * as fs from 'fs';
import * as readline from 'readline';

const regex = /(mul\((\d+),(\d+)\)|do\(\)|don't\(\))/g;

const filePath = "input.txt"
const fileStream = fs.createReadStream(filePath);

const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
})

let board: number[][] = [];

let answer = 0;
let flag = 1;
rl.on("line", (line) => {
    let match: RegExpExecArray | null;
    while ((match = regex.exec(line)) !== null) {
        if (match[1].startsWith("mul")) {
            const [, , num1, num2] = match;
            answer += parseInt(num1, 10) * parseInt(num2, 10) * flag;
        } else if (match[1].startsWith("do()")) {
            flag = 1;
        } else if (match[1].startsWith("don't()")) {
            flag = 0;
        }
    }
})


rl.on("close", () => {
    console.log(answer);
});

