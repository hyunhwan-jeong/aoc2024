import * as fs from 'fs';
import * as readline from 'readline';

const filePath = "input.txt"
const fileStream = fs.createReadStream(filePath);

const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
})

let board: string[] = [];

let answer = 0;
rl.on("line", (line) => {
    board.push(line)
})


function countOccurrences(array: number[], X: number): number {
    return array.reduce((count, value) => (value === X ? count + 1 : count), 0);
}

function countXMAS(array: string[], target: string): number {
    let count: number = 0;
    const N: number = array.length;
    const M: number = array[0].length
    const X: number = target.length
    console.log(N, M, X)
    console.log(target);
    for(let i = 0 ; i < N ; ++i) {
        for(let j = 0 ; j < M ; ++j) {
            let sum: number[] = [0,0,0,0];
            for(let k = 0 ; k < X && i+k < N ; ++k) {
                if(target[k] == array[i+k][j]) ++sum[0];
            }
            for(let k = 0 ; k < X && j+k < M ; ++k) {
                if(target[k] == array[i][j+k]) ++sum[1];
            }
            for(let k = 0 ; k < X && i+k < N && j+k < M ; ++k) {
                if(target[k] == array[i+k][j+k]) ++sum[2];
            }
            for(let k = 0 ; k < X && i+k < N && j-k >= 0 ; ++k) {
                if(target[k] == array[i+k][j-k]) ++sum[3];
            }
            console.log(i, j, sum);
            count += countOccurrences(sum, X);
       }
    }
    
    return count;
}

rl.on("close", () => {    
    console.log(countXMAS(board, "XMAS") + countXMAS(board, "SAMX"))
});

