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
    var cache = Array(repeating: Array(repeating: 0, count: cols), count: rows)
    
    // Directions for moving up, down, left, and right
    let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

    cache[startRow][startCol] = 1    

    for height in 0...8 {
        for i in 0..<rows {
            for j in 0..<cols {
                if matrix[i][j] != height {
                    continue
                }
                for direction in directions {
                    let newRow = i + direction.0
                    let newCol = j + direction.1
                
                    if newRow < 0 || newRow >= rows {
                        continue
                    }
                    if newCol < 0 || newCol >= cols {
                        continue
                    }
                    if inputMap[newRow][newCol] == height + 1 {
                        cache[newRow][newCol] += cache[i][j] 
                    }
                }
            }
        }
    }

    for i in 0..<rows {
        for j in 0..<cols {
            if matrix[i][j] == 9 {
                answer += cache[i][j]
            }
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