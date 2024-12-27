import Foundation
import FirebaseFirestore

struct Transaction {
    let id: String
    let amount: Double
    let categoryId: String
    let balanceId: String
    let date: Date
    let note: String
    let type: String
//    let category: Category? {
//        return FirestoreManager.shared.categories.first { $0.identifier == categoryId }
//    }

    init(id: String, data: [String: Any]) {
        self.id = id
        self.amount = data["amount"] as? Double ?? 0.0
        self.categoryId = data["categoryId"] as? String ?? ""
        self.balanceId = data["balanceId"] as? String ?? ""
        self.date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
        self.note = data["note"] as? String ?? ""
        self.type = data["type"] as? String ?? "expense"
    }

    func toDictionary() -> [String: Any] {
        return [
            "amount": amount,
            "categoryId": categoryId,
            "balanceId": balanceId,
            "date": Timestamp(date: date),
            "note": note,
            "type": type
        ]
    }
}
