import * as fs from 'fs';
import * as readline from 'readline';

const filePath = "P2.in"
const fileStream = fs.createReadStream(filePath);

const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
})

let board: number[][] = [];


function check(report: number[]): boolean {
    const diff: number[] = [];
    for(let i=1; i<report.length; ++i) {
        diff.push(report[i]-report[i-1]);
    }
    const allPositive = diff.every((n) => n > 0);
    const allNegative = diff.every((n) => n < 0);
    const withinRange = diff.every((n) => Math.abs(n) <= 3);

    return (allPositive || allNegative) && withinRange;

}

let answer = 0;
rl.on("line", (line) => {
    const report = line.split(" ").map((num) => parseInt(num, 10));
    if(check(report)) {
        answer++;
    } else {
        for(let i = 0 ; i < report.length; ++i) {
            const newReport = [...report.slice(0, i), ...report.slice(i+1)];
            if(check(newReport)) {
                answer++;
                break;
            }           
        }
    }
})

rl.on("close", () => {
    console.log(answer)
});

