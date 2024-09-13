

var fru = ["apple", "banana", "cherry"]
print("the third fruit is: \(fru[2])")

var favn: Set = [7, 14, 21]
favn.insert(28)
print("updated set of favorite numbers: \(favn)")

var pro = ["Python": 1991, "Java": 1995, "Swift": 2014]
if let swif = pro["Swift"] {
    print("swift was released in: \(swif)")
}

var color = ["red", "blue", "green", "yellow"]
color[1] = "purple"
print("updated array of colors: \(color)")

let set1: Set = [1, 2, 3, 4]
let set2: Set = [3, 4, 5, 6]
let intersn = set1.intersection(set2)
print("intersection of the sets: \(intersn)")

var stuscores = ["Alice": 85, "Bob": 90, "Charlie": 78]
stuscores["Bob"] = 95
print("updated student scores: \(stuscores)")

let array1 = ["apple", "banana"]
let array2 = ["cherry", "date"]
let merray = array1 + array2
print("merged array: \(merray)")

var Population = ["USA": 331_000_000, "India": 1_380_000_000, "China": 1_440_000_000]
Population["Brazil"] = 213_000_000
print("updated country populations: \(Population)")

let set3: Set = ["cat", "dog"]
let set4: Set = ["dog", "mouse"]
let unionSet = set3.union(set4)
let finalSet = unionSet.subtracting(set4)
print("final set : \(finalSet)")

var Grades = [
    "Alice": [88, 92, 85],
    "Bob": [78, 81, 79],
    "Charlie": [90, 85, 88]
]
if let Grades = Grades["Alice"] {
    print("grade for Alice: \(Grades[1])")
}