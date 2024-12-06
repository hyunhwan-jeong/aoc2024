import * as fs from 'fs';
import * as readline from 'readline';

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
