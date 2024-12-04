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



function countMAS(array: string[]): number {
    let count: number = 0;
    const N: number = array.length;
    const M: number = array[0].length
    for(let i = 1 ; i < N-1 ; ++i) {
        for(let j = 1 ; j < M-1 ; ++j) {
            if(array[i][j]!='A') {
                continue;
            }
            
            /*if( (array[i-1][j] == 'M' && array[i+1][j] == 'S') ||
                (array[i-1][j] == 'S' && array[i+1][j] == 'M'))
                    if( (array[i][j-1] == 'M' && array[i][j+1] == 'S') ||
                        (array[i][j-1] == 'S' && array[i][j+1] == 'M')) {
                        ++count;
                }*/

            if( (array[i-1][j-1] == 'M' && array[i+1][j+1] == 'S') ||
                (array[i-1][j-1] == 'S' && array[i+1][j+1] == 'M'))
                    if( (array[i-1][j+1] == 'M' && array[i+1][j-1] == 'S') ||
                        (array[i-1][j+1] == 'S' && array[i+1][j-1] == 'M')) {
                        ++count;
                }

       }
    }
    
    return count;
}

rl.on("close", () => {    
    console.log(countMAS(board));
                
});

