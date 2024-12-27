import FirebaseFirestore

class TransactionManager {
    static let shared = TransactionManager()
    private let db = Firestore.firestore()

    func fetchTransactions(userId: String, completion: @escaping (Result<[Transaction], Error>) -> Void) {
        db.collection("users").document(userId).collection("transactions").order(by: "date", descending: true).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let transactions = snapshot.documents.map { Transaction(id: $0.documentID, data: $0.data()) }
                completion(.success(transactions))
            }
        }
    }

//    func addTransaction(userId: String, transaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void) {
//            let transactionData = transaction.toDictionary()
//            let balanceRef = db.collection("users").document(userId).collection("balances").document(transaction.balanceId)
//
//            // Use Firestore transaction for atomic update
//            db.runTransaction { (firestoreTransaction, errorPointer) -> Any? in
//                // Step 1: Add the new transaction
//                let transactionRef = self.db.collection("users").document(userId).collection("transactions").document()
//                firestoreTransaction.setData(transactionData, forDocument: transactionRef)
//
//                // Step 2: Fetch the balance document
//                let balanceSnapshot: DocumentSnapshot
//                do {
//                    balanceSnapshot = try firestoreTransaction.getDocument(balanceRef)
//                } catch let fetchError {
//                    errorPointer?.pointee = fetchError as NSError
//                    return nil
//                }
//
//                // Step 3: Calculate the updated amount
//                guard let currentAmount = balanceSnapshot.data()?["amount"] as? Double else {
//                    errorPointer?.pointee = NSError(
//                        domain: "TransactionManager",
//                        code: 404,
//                        userInfo: [NSLocalizedDescriptionKey: "Balance not found or invalid data."]
//                    )
//                    return nil
//                }
//
//                let newAmount: Double
//                if transaction.type == "expense" {
//                    newAmount = currentAmount - transaction.amount
//                } else if transaction.type == "income" {
//                    newAmount = currentAmount + transaction.amount
//                } else {
//                    errorPointer?.pointee = NSError(
//                        domain: "TransactionManager",
//                        code: 400,
//                        userInfo: [NSLocalizedDescriptionKey: "Invalid transaction type."]
//                    )
//                    return nil
//                }
//
//                // Step 4: Update the balance amount
//                firestoreTransaction.updateData(["amount": newAmount], forDocument: balanceRef)
//
//                return nil
//            } completion: { (_, error) in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.success(()))
//                }
//            }
//        }

    func addTransaction(userId: String, transaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void) {
        let transactionData = transaction.toDictionary()
        let balanceRef = db.collection("users").document(userId).collection("balances").document(transaction.balanceId)

        db.runTransaction { (firestoreTransaction, errorPointer) -> Any? in
            // Step 1: Fetch the balance document (READ FIRST)
            let balanceSnapshot: DocumentSnapshot
            do {
                balanceSnapshot = try firestoreTransaction.getDocument(balanceRef)
            } catch let fetchError {
                errorPointer?.pointee = fetchError as NSError
                return nil
            }

            // Step 2: Calculate the updated amount
            guard let currentAmount = balanceSnapshot.data()?["amount"] as? Double else {
                errorPointer?.pointee = NSError(
                    domain: "TransactionManager",
                    code: 404,
                    userInfo: [NSLocalizedDescriptionKey: "Balance not found or invalid data."]
                )
                return nil
            }

            let newAmount: Double
            if transaction.type == "expense" {
                newAmount = currentAmount - transaction.amount
            } else if transaction.type == "income" {
                newAmount = currentAmount + transaction.amount
            } else {
                errorPointer?.pointee = NSError(
                    domain: "TransactionManager",
                    code: 400,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid transaction type."]
                )
                return nil
            }

            // Step 3: Add the new transaction (WRITE)
            let transactionRef = self.db.collection("users").document(userId).collection("transactions").document()
            firestoreTransaction.setData(transactionData, forDocument: transactionRef)

            // Step 4: Update the balance amount (WRITE)
            firestoreTransaction.updateData(["amount": newAmount], forDocument: balanceRef)

            return nil
        } completion: { (_, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func updateTransaction(userId: String, transaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users")
            .document(userId)
            .collection("transactions")
            .document(transaction.id)
            .updateData(transaction.toDictionary()) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }

    func deleteTransaction(userId: String, transactionId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users")
            .document(userId)
            .collection("transactions")
            .document(transactionId)
            .delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
}
