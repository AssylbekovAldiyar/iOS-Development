import FirebaseFirestore

class BalanceManager {
    static let shared = BalanceManager()
    private let db = Firestore.firestore()

    func fetchBalances(userId: String, completion: @escaping (Result<[Balance], Error>) -> Void) {
        db.collection("users").document(userId).collection("balances").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let balances = snapshot.documents.map { Balance(id: $0.documentID, data: $0.data()) }
                completion(.success(balances))
            }
        }
    }

    func addBalance(userId: String, balance: Balance, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(userId).collection("balances").addDocument(data: balance.toDictionary()) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func updateBalanceAmount(userId: String, balanceId: String, newAmount: Double, completion: @escaping (Result<Void, Error>) -> Void) {
            let balanceRef = db.collection("users").document(userId).collection("balances").document(balanceId)

            balanceRef.updateData(["amount": newAmount]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }

    func updateBalance(userId: String, balance: Balance, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users")
            .document(userId)
            .collection("balances")
            .document(balance.id)
            .updateData(balance.toDictionary()) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }

    func deleteBalance(userId: String, balanceId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users")
            .document(userId)
            .collection("balances")
            .document(balanceId)
            .delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
}
