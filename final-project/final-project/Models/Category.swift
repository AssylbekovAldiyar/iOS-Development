import Foundation

struct Category {
    let id: String
    var name: String
    var color: String
    var amount: Double

    init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.color = data["color"] as? String ?? "#FFFFFF"
        self.amount = data["amount"] as? Double ?? 0
    }

    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "color": color
        ]
    }
}
