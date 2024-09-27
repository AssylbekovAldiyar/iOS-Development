
// Problem 8: Palindrome Checker
func isPalindrome(_ text: String) -> Bool {
    let filteredText = text.lowercased().filter { $0.isLetter }
    return filteredText == String(filteredText.reversed())
}

// Problem 9: Simple Calculator
func simpleCalculator() {
    while true {
        print("Enter first number:")
        if let firstInput = readLine(), let firstNum = Double(firstInput) {
            print("Enter second number:")
            if let secondInput = readLine(), let secondNum = Double(secondInput) {
                print("Choose operation (+, -, *, /) or type 'exit' to quit:")
                if let operation = readLine() {
                    switch operation {
                    case "+":
                        print("Result: \(firstNum + secondNum)")
                    case "-":
                        print("Result: \(firstNum - secondNum)")
                    case "*":
                        print("Result: \(firstNum * secondNum)")
                    case "/":
                        if secondNum != 0 {
                            print("Result: \(firstNum / secondNum)")
                        } else {
                            print("Cannot divide by zero!")
                        }
                    case "exit":
                        return
                    default:
                        print("Invalid operation")
                    }
                }
            }
        }
    }
}

// Problem 10: Unique Characters
func hasUniqueCharacters(_ text: String) -> Bool {
    var characterSet = Set<Character>()
    for char in text {
        if characterSet.contains(char) {
            return false
        }
        characterSet.insert(char)
    }
    return true
}

