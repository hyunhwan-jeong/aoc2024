import Foundation

// Read the input file
let fileURL = URL(fileURLWithPath: "input.txt")
let fileContents = try String(contentsOf: fileURL, encoding: .utf8)

// Split the contents into lines, excluding empty ones
let lines = fileContents.components(separatedBy: .newlines).filter { !$0.isEmpty }

print(lines)
// Parse the input based on the pattern

// Extract integers from each line using regex
let extractedNumbers = lines.map { line -> [Int] in
    line
        .components(separatedBy: CharacterSet.decimalDigits.inverted) // Split by non-numeric characters
        .compactMap { Int($0) } // Convert valid components to Int
}

var answer = 0
// Print results
for i in stride(from: 0, to: extractedNumbers.count, by: 3) { 
    let AX = extractedNumbers[i][0]
    let AY = extractedNumbers[i][1]
    let BX = extractedNumbers[i+1][0]
    let BY = extractedNumbers[i+1][1]
    let X = extractedNumbers[i+2][0]
    let Y = extractedNumbers[i+2][1]

    var best = -1
    for buttonA in 0...100 {
        for buttonB in 0...100 {
            if AX * buttonA + BX * buttonB == X && AY * buttonA + BY * buttonB == Y {
                if best == -1 || best > 3 * buttonA + buttonB {
                    best = 3 * buttonA + buttonB
                }
            }
        }
    }
    if best != -1 {
        print(i, best)
        answer += best
    }
}

print(answer)