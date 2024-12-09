use std::fs::File;
use std::io::{self, BufRead};

fn main() -> io::Result<()> {
    let path = "input.txt";
    let file = File::open(&path)?;
    let reader = io::BufReader::new(file);
    
    let board: Vec<Vec<char>> = reader
        .lines()
        .filter_map(Result::ok)
        .map(|line| line.chars().collect())
        .collect();

    let mut antinode: Vec<Vec<bool>> = board
        .iter()
        .map(|row| vec![false; row.len()])
        .collect();

    for i in 0..board.len() {
        for j in 0..board[i].len() {
            if board[i][j] == '.' {
                continue;           
            }
            for k in i..board.len() {
                for l in 0..board[k].len() {
                    if board[k][l] == '.' {
                        continue;
                    }
                    if i == k && j == l {
                        continue;
                    }
                    
                    if board[i][j] != board[k][l] {
                        continue;
                    }

                    let disp_row = k as isize - i as isize;
                    let disp_col = l as isize - j as isize;
                    
                    // Check bounds and update (k + disp_row, l + disp_col)
                    if k as isize + disp_row >= 0
                        && (k as isize + disp_row) < antinode.len() as isize
                        && l as isize + disp_col >= 0
                        && (l as isize + disp_col) < antinode[k].len() as isize
                    {
                        antinode[(k as isize + disp_row) as usize][(l as isize + disp_col) as usize] = true;
                    }
                    
                    // Check bounds and update (i - disp_row, j - disp_col)
                    if i as isize - disp_row >= 0
                        && (i as isize - disp_row) < antinode.len() as isize
                        && j as isize - disp_col >= 0
                        && (j as isize - disp_col) < antinode[i].len() as isize
                    {
                        antinode[(i as isize - disp_row) as usize][(j as isize - disp_col) as usize] = true;
                    }
                                    }
            }
        }
    }

    let num_antinodes: usize = antinode
        .iter()
        .map(|row| row.iter().filter(|&&value| value).count())
        .sum();

    println!("{}", num_antinodes);
        
            

    
    Ok(())
}
