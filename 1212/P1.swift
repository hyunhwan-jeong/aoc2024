import Foundation

let fileURL = URL(fileURLWithPath: "input.txt")
let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
let lines = fileContents.components(separatedBy: .newlines).filter { !$0.isEmpty }

var inputMap = lines.map { line in
    line.map { char in String(char) }
}

let rows = inputMap.count
let cols = rows > 0 ? inputMap[0].count : 0

// Keep track of visited cells
var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)

// List to store visited groups
var visitedGroups: [[(Int, Int)]] = []

func dfs(groupId: String, row: Int, col: Int, group: inout [(Int, Int)]) {
    // Check bounds
    if row < 0 || row >= rows || col < 0 || col >= cols {
        return
    }

    // Check if already visited or mismatched groupId
    if visited[row][col] || inputMap[row][col] != groupId {
        return
    }

    // Mark as visited
    visited[row][col] = true
    group.append((row, col))

    // Visit adjacent cells (horizontal and vertical)
    dfs(groupId: groupId, row: row - 1, col: col, group: &group) // Up
    dfs(groupId: groupId, row: row + 1, col: col, group: &group) // Down
    dfs(groupId: groupId, row: row, col: col - 1, group: &group) // Left
    dfs(groupId: groupId, row: row, col: col + 1, group: &group) // Right
}

for row in 0..<rows {
    for col in 0..<cols {
        if !visited[row][col] {
            var group: [(Int, Int)] = []
            dfs(groupId: inputMap[row][col], row: row, col: col, group: &group)
            visitedGroups.append(group)
        }
    }
}

var answer = 0

for (index, group) in visitedGroups.enumerated() {
    print("Group \(index + 1):")

    var perimeter = 0

    for cell in group {
        let row = cell.0
        let col = cell.1
        let currentGroup = inputMap[row][col]
        if row-1 < 0 || inputMap[row-1][col] != currentGroup {
            perimeter += 1
        }
        if row+1 >= rows || inputMap[row+1][col] != currentGroup {
            perimeter += 1
        }
        if col-1 < 0 || inputMap[row][col-1] != currentGroup {
            perimeter += 1
        }
        if col+1 >= cols || inputMap[row][col+1] != currentGroup {
            perimeter += 1
        }
    }

    let value = group.count * perimeter 
    print(value)
    answer += value
    
}

print(answer)