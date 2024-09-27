import Foundation

// Problem 1:
func fizzBuzz() {
    for i in 1...100 {
        if i % 3 == 0 && i % 5 == 0 {
            print("FizzBuzz")
        } else if i % 3 == 0 {
            print("Fizz")
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}

// Problem 2
func isprime(_ number: Int) -> Bool {
    if number < 2 { return false }
    for i in 2..<number {
        if number % i == 0 {
            return false
        }
    }
    return true
}

func printprime() {
    for i in 1...100 {
        if isprime(i) {
            print("\(i) is a prime number")
        }
    }
}

// Problema 3
func convertTemperature() {
    print("Enter temperature value:")
    if let input = readLine(), let temperature = Double(input) {
        print("Enter unit (C for Celsius, F for Fahrenheit, K for Kelvin):")
        if let unit = readLine() {
            switch unit.uppercased() {
            case "C":
                print("Fahrenheit: \((temperature * 9/5) + 32)")
                print("Kelvin: \(temperature + 273.15)")
            case "F":
                print("Celsius: \((temperature - 32) * 5/9)")
                print("Kelvin: \((temperature - 32) * 5/9 + 273.15)")
            case "K":
                print("Celsius: \(temperature - 273.15)")
                print("Fahrenheit: \((temperature - 273.15) * 9/5 + 32)")
            default:
                print("Invalid unit")
            }
        }
    }
}

// Problema 4
func shoppinglistmanager() {
    var shoppingList = [String]()
    while true {
        print("""
        Shopping List Manager:
        1. Add item
        2. Remove item
        3. View list
        4. Exit
        """)
        if let choice = readLine() {
            switch choice {
            case "1":
                print("Enter item to add:")
                if let item = readLine() {
                    shoppingList.append(item)
                    print("\(item) added to the list.")
                }
            case "2":
                print("Enter item to remove:")
                if let item = readLine(), let index = shoppingList.firstIndex(of: item) {
                    shoppingList.remove(at: index)
                    print("\(item) removed from the list.")
                } else {
                    print("Item not found.")
                }
            case "3":
                print("Shopping list: \(shoppingList)")
            case "4":
                return
            default:
                print("Invalid option")
            }
        }
    }
}
