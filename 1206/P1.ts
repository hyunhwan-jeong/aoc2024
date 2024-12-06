import * as fs from 'fs';
import * as readline from 'readline';

const filePath = "input.txt";
const fileStream = fs.createReadStream(filePath);

const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
});

const board: string[] = [];

let answer = 0;
rl.on("line", (line) => {
    board.push(line);
});

rl.on("close", () => {    
    const N = board.length;
    const M = board[0].length;
    const visited = Array.from({length: N}, () => Array(M).fill(false));
    
    let [guardR, guardC] = [NaN, NaN];
    for(let i = 0 ; i < N ; ++i) {
        for(let j = 0 ; j < M ; ++j) {
            if(board[i][j]=='^') {
                guardR = i;
                guardC = j;
            }
        }
    }

    let dir: number = 0;
    const dispR: number[] = [-1,0,1,0];
    const dispC: number[] = [0,1,0,-1];

    while(true) {
        console.log(guardR, guardC, visited[guardR][guardC])
        if(!visited[guardR][guardC]) {
            ++answer;
        }
        visited[guardR][guardC] = true;
        const newR = guardR + dispR[dir];
        const newC = guardC + dispC[dir];
        if(newR < 0 || newR >= N) break;
        if(newC < 0 || newC >= M) break;
        if(board[newR][newC]=='#') {
            dir = (dir+1) % 4;
        } else {
            [guardR, guardC] = [newR, newC];
        }
        
        /*for(let i=0;i<N;++i) {
            for(let j=0;j<M;++j) {
                if(i==guardR && j==guardC) {
                    process.stdout.write("G");
                }
                else if(visited[i][j]) {
                    process.stdout.write("*");
                } else {
                    process.stdout.write(board[i][j]);
                }
            }
            console.log();
        }*/
        
    }

    console.log(answer);
});
