import * as fs from 'fs';
import * as readline from 'readline';

const filePath = "P1.in"
const fileStream = fs.createReadStream(filePath);

const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
})

let board: number[][] = [];

let answer = 0;
rl.on("line", (line) => {
    const report = line.split(" ").map((num) => parseInt(num, 10));

    let diff: number[] = [];
    for(let i=1; i<report.length; ++i) {
        diff.push(report[i]-report[i-1]);
    }

    if(diff.every((n)=>(n>0)) || diff.every((n)=>(n<0))) {
        if(diff.every((n)=>(Math.abs(n)<=3))) ++answer;
    }
    
})

rl.on("close", () => {
    console.log(answer)
});

