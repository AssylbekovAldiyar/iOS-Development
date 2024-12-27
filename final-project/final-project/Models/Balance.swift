import Foundation

struct Balance {
    let id: String
    var name: String
    var amount: Double

    init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.amount = data["amount"] as? Double ?? 0.0
    }

    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "amount": amount
        ]
    }
}
