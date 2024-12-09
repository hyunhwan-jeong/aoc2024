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
            antinode[i][j] = true;
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
                    
                    antinode[k][l] = true;
                    let disp_row = k as isize - i as isize;
                    let disp_col = l as isize - j as isize;
                    
                    let mut current_row = k as isize + disp_row;
                    let mut current_col = l as isize + disp_col;

                    loop {
                        if current_row < 0
                            || current_row >= board.len() as isize 
                            || current_col < 0 
                            || current_col >= board[0].len() as isize {
                                break;
                            }
                            antinode[current_row as usize][current_col as usize] = true;
                            current_row += disp_row;
                            current_col += disp_col;
                    }

                    current_row = i as isize - disp_row;
                    current_col = j as isize - disp_col;

                    loop {
                        if current_row < 0
                            || current_row >= board.len() as isize
                            || current_col < 0
                            || current_col >= board[0].len() as isize {
                            break;
                        }
                        antinode[current_row as usize][current_col as usize] = true;
                        current_row -= disp_row; 
                        current_col -= disp_col;
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
