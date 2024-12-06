import * as fs from 'fs';
import * as readline from 'readline';

const filePath = "input.txt";
const fileStream = fs.createReadStream(filePath);

const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
});

let answer: number = 0;
let isFirst: boolean = true;
const invalid = new Set<string>();

rl.on("line", (line) => {
    if(line.length==0) {
        isFirst = false;
    } else {
        if(isFirst) {
            const [a, b] = line.split("|").map(Number);
            invalid.add(`${b},${a}`);
        } else {
            const numbers = line.split(",").map(Number);
            let isCorrect: boolean = true;

            for(let i = 0 ; i<numbers.length ; ++i ) {
                for(let j=i+1 ; j < numbers.length ; ++j) {
                    console.log(`${numbers[i]},${numbers[j]}`);
                    if(invalid.has(`${numbers[i]},${numbers[j]}`)) {
                        isCorrect = false;
                        [numbers[i], numbers[j]] = [numbers[j], numbers[i]];
                    }
                }
            }
            if(!isCorrect) {
                console.log(numbers, isCorrect, numbers[Math.floor(numbers.length/2)]);
                
                answer += numbers[Math.floor(numbers.length/2)];
            }    
        }
    }
});

rl.on("close", () => {    
    console.log(answer);
});
