import Foundation


var P : [[Int]] = []
var V : [[Int]] = []

// Replace "path/to/file.txt" with your file's path
if let content = try? String(contentsOfFile: "input.txt", encoding: .utf8) {
    let lines = content.split(separator: "\n")
    lines.forEach { line in 
        let strLine = String(line)
        let scanner = Scanner(string: strLine)
        let skippedCharacters = CharacterSet(charactersIn: " p=v,")
        scanner.charactersToBeSkipped = skippedCharacters

        var p1: Int = 0
        var p2: Int = 0
        var v1: Int = 0
        var v2: Int = 0
        scanner.scanInt(&p1)
        scanner.scanInt(&p2)
        scanner.scanInt(&v1)
        scanner.scanInt(&v2)
        P.append([p1,p2])
        V.append([v1,v2])
     }
} else {
    print("Failed to read the file.")
}

let WIDTH = 11
let HEIGHT: Int = 7


for _ in 1...100 {
    for i in 0..<P.count {
        P[i][0] = ((P[i][0] + V[i][0]) % WIDTH + WIDTH) % WIDTH
        P[i][1] = ((P[i][1] + V[i][1]) % HEIGHT + HEIGHT) % HEIGHT
    }
}


var quadrant = [0, 0, 0, 0]

let middleRow = HEIGHT / 2
let middleCol = WIDTH / 2
for robot in P {
    let x = robot[0]
    let y = robot[1]

    if y == middleRow || x == middleCol {
        continue
    }    

    let place = (y > middleRow ? 2 : 0) + (x > middleCol ? 1 : 0)
    quadrant[place] += 1
}

print(quadrant[0]*quadrant[1]*quadrant[2]*quadrant[3])