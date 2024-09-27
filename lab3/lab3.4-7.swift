// Problem 5
func wordFrequencyCounter() {
    print("Enter a sentence:")
    if let sentence = readLine() {
        let words = sentence.lowercased().components(separatedBy: CharacterSet.punctuationCharacters.union(.whitespaces))
        var wordCount = [String: Int]()
        for word in words where !word.isEmpty {
            wordCount[word, default: 0] += 1
        }
        for (word, count) in wordCount {
            print("\(word): \(count)")
        }
    }
}

// Problem 6
func fibonacci(_ n: Int) -> [Int] {
    if n <= 0 { return [] }
    var sequence = [0, 1]
    for i in 2..<n {
        sequence.append(sequence[i - 1] + sequence[i - 2])
    }
    return sequence
}

// Problem 7
func gradeCalculator() {
    var students = [String: Int]()
    while true {
        print("Enter student name (or type 'done' to finish):")
        if let name = readLine(), name.lowercased() != "done" {
            print("Enter score for \(name):")
            if let scoreStr = readLine(), let score = Int(scoreStr) {
                students[name] = score
            }
        } else {
            break
        }
    }
    
    let scores = students.values
    let average = scores.reduce(0, +) / students.count
    let highest = scores.max() ?? 0
    let lowest = scores.min() ?? 0
    
    print("Average score: \(average)")
    print("Highest score: \(highest)")
    print("Lowest score: \(lowest)")
    
    for (name, score) in students {
        let comparison = score >= average ? "above" : "below"
        print("\(name): \(score) (\(comparison) average)")
    }
}
