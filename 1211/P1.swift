import Foundation

let fileURL = URL(fileURLWithPath: "input.txt")
let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
var stones = fileContents.components(separatedBy: .whitespaces)

func correct(_ number: String) -> String {
    var number = number
    while number.first == "0" && number.count > 1 {
        number.removeFirst()
    }
    return number
}

for _ in 1...25 {
    var nextStones: [String] = []

    for stone in stones {
        if stone == "0" {
            nextStones.append("1")
        } else if stone.count % 2 == 0 {
            let middle = stone.count / 2
            let startIndex = stone.startIndex
            let middleIndex = stone.index(startIndex, offsetBy: middle)
            nextStones.append(String(stone[..<middleIndex]))
            nextStones.append(correct(String(stone[middleIndex...])))
        } else if let stoneValue = Int(stone) {
            nextStones.append(String(stoneValue * 2024))
        }
    }

    stones = nextStones
    // print(stones)
}

print(stones.count)
