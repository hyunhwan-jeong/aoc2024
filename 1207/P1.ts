import { match } from 'assert';
import * as fs from 'fs';
import * as readline from 'readline';

const filePath = "input.txt";
const fileStream = fs.createReadStream(filePath);

const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
});

let answer = 0;

function findMatch(target: number, sequence: number[] ) {
    const sets : [Set<number>, Set<number>] = [new Set(), new Set()];
    const N = sequence.length;
    
    sets[1].add(sequence[0]);

    for(let i = 1 ; i < N ; ++i) {
        const next = (i+1)%2;
        const cur = i%2;
        sets[next].clear();
        sets[cur].forEach((x) => {
            sets[next].add(x+sequence[i]);
            sets[next].add(x*sequence[i]);
        });
    }
    
    return sets[N%2].has(target);
}
rl.on("line", (line) => {
    let [tmpTarget, tmpSequence] = line.split(": ");
    let target = Number(tmpTarget);
    let sequence = tmpSequence.split(" ").map(Number);
    answer += findMatch(target, sequence) ? target : 0;
});

rl.on("close", () => {    
    console.log(answer);
});
