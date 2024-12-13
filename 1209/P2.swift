import Foundation

let fileURL = URL(fileURLWithPath: "input.txt")
let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
let lines = fileContents.components(separatedBy: .newlines)
let input: String = lines.first!
let diskMap: [Int] = input.map{Int(String($0))!}

var diskId = -1;

var disks: [Int] = []

for (i, steps) in diskMap.enumerated() {
    if i % 2 == 0 {
        diskId += 1
    }
    if steps == 0 {
        continue
    }
    for _ in 1...steps {
        if i % 2 == 0 {
            disks.append(diskId)
        } else {
            disks.append(-1)
        }
    }
}


var l = 0
var r: Int = disks.count - 1

while l < r {
    if disks[l] == -1 && disks[r] != -1 {
        disks.swapAt(l, r)
        l += 1
        r -= 1
    } else {
        if disks[l] != -1 {
            l += 1
        }
        if disks[r] == -1 {
            r -= 1
        }
    }
}

var answer = 0

for (i, v) in disks.enumerated() {
    if v != -1 {
        answer += i * v 
    }
    
}
print(disks)
print(answer)