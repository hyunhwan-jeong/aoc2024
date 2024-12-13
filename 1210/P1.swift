import Foundation

let fileURL = URL(fileURLWithPath: "input.txt")
let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
let lines = fileContents.components(separatedBy: .newlines)

var inputMap = lines.map{
    line in line.map {
        char in Int(String(char))!
        
    }
}


func bfsMatrix(matrix: [[Int]], startRow: Int, startCol: Int) -> Int {
    var answer: Int = 0
    let rows = matrix.count
    let cols = matrix[0].count
    var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
    var queue: [(row: Int, col: Int)] = [(startRow, startCol)]
    
    // Directions for moving up, down, left, and right
    let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    
    // Mark the start position as visited
    visited[startRow][startCol] = true
    
    while !queue.isEmpty {
        
        let (currentRow, currentCol) = queue.removeFirst()
        if matrix[currentRow][currentCol] == 9 {
            answer += 1
            continue
        }        
        // Explore neighbors
        for direction in directions {
            let newRow = currentRow + direction.0
            let newCol = currentCol + direction.1
            
            if newRow < 0 || newRow >= rows {
                continue
            }
            if newCol < 0 || newCol >= cols {
                continue
            }
            if visited[newRow][newCol] {
                continue
            }
            if matrix[newRow][newCol]-matrix[currentRow][currentCol] != 1 {
                continue
            }
            // Check bounds and if the cell is not visited
            queue.append((newRow, newCol))
            visited[newRow][newCol] = true
        }
    }

    return answer
}

var answer = 0
for i in 0..<inputMap.count {
    for j in 0..<inputMap[i].count {
        if inputMap[i][j] == 0 {
            print(i, j)
            answer += bfsMatrix(matrix: inputMap, startRow: i, startCol: j)
        }
    }
}

print(answer)