import Foundation

let fileURL = URL(fileURLWithPath: "input.txt")
let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
var stones = fileContents.components(separatedBy: .whitespaces)



var memo: [String: Int] = [:] // Memoization dictionary

func correct(_ number: String) -> String {
    var number = number
    while number.first == "0" && number.count > 1 {
        number.removeFirst()
    }
    return number
}

func processStone(_ stone: String, remainIter: Int) -> Int {
    // Check memoization cache
    let dictKey = "\(stone)_\(remainIter)" 
    if let cachedResult = memo[dictKey] {
        return cachedResult
    }

    // Base case: if no iterations remain, count this stone as 1
    if remainIter == 0 {
        return 1
    }


    var result = 0

    if stone == "0" {
        result = processStone( "1", remainIter: remainIter - 1)
    } else if stone.count % 2 == 0 {
        let middle = stone.count / 2
        let startIndex = stone.startIndex
        let middleIndex = stone.index(startIndex, offsetBy: middle)
        result = processStone(String(stone[..<middleIndex]), remainIter: remainIter - 1) +  
        processStone(correct(String(stone[middleIndex...])), remainIter: remainIter - 1)
    } else if let stoneValue = Int(stone) {
        let newStone = String(stoneValue * 2024)
        result = processStone(newStone, remainIter: remainIter - 1)
    }
    memo[dictKey] = result
    return result
}

var answer = 0
for stone in stones {
    answer += processStone(stone, remainIter: 75)
}
print(answer)