import Foundation

let fileURL = URL(fileURLWithPath: "input.txt")
let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
let lines = fileContents.components(separatedBy: .newlines)
let input: String = lines.first!
let diskMap: [Int] = input.map{Int(String($0))!}

var diskId = -1;

var disks : [(start: Int, end: Int, index: Int)] = []
var spaces : [(start: Int, end: Int)] = []

var diskStatus: [Int] = []
var n: Int = 0

for (i, steps) in diskMap.enumerated() {
    if i % 2 == 0 {
        diskId += 1
        disks.append((start: n, end: n+steps, index: diskId))
    }
    if steps == 0 {
        continue
    }
    for _ in 1...steps {
        if i % 2 == 0 {
            diskStatus.append(diskId)
        } else {
            diskStatus.append(-1)
        }
    }
    n += steps
}

for disk in disks.reversed() {
    let targetCount = disk.end - disk.start 

    var startIdx: Int? = nil
    var endIdx: Int? = nil
    var consecutiveCount = 0
    for (i, v) in diskStatus.enumerated()  {
        if i >= disk.start {
            break
        }
        if v == -1 {
            if consecutiveCount == 0 {
                startIdx = i
            }
            consecutiveCount += 1
        } else {
            consecutiveCount = 0
            startIdx = nil
        }

        if consecutiveCount >= targetCount {
            endIdx = i
            break
        }
    }

    if endIdx != nil {
        //print(startIdx, endIdx, targetCount, disk)
        if let startIdx = startIdx, let endIdx = endIdx {
            var j = disk.end-1
            for i in startIdx...endIdx {
                diskStatus.swapAt(i, j)
                j -= 1
            }
        }

    }
 
}

var answer = 0
for (i, v) in diskStatus.enumerated() {
    answer += i * max(v, 0)
}

print(answer)