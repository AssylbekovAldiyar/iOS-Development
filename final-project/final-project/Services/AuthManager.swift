import FirebaseAuth
import FirebaseFirestore

class AuthManager {
    static let shared = AuthManager()
    private let db = Firestore.firestore()
    
    func createNewUser(email: String, password: String, name: String? = nil, completion: @escaping (Result<Void, Error>) -> Void) {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }

                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let userId = result?.user.uid else {
                    completion(.failure(NSError(domain: "UserManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user ID."])))
                    return
                }

                // Step 2: Initialize the user's document in Firestore
                let userDocument: [String: Any] = [
                    "email": email,
                    "name": name ?? "Unknown",
                    "createdAt": Timestamp(date: Date())
                ]

                let batch = self.db.batch()

                // Add user document
                let userRef = self.db.collection("users").document(userId)
                batch.setData(userDocument, forDocument: userRef)

                // Step 3: Initialize default categories
                let defaultCategories = [
                    ["name": "Food", "color": "#FF5733", "amount": 0.0],
                    ["name": "Rent", "color": "#33FF57", "amount": 0.0],
                    ["name": "Entertainment", "color": "#3357FF", "amount": 0.0]
                ]

                let categoriesCollection = userRef.collection("categories")
                for category in defaultCategories {
                    let categoryRef = categoriesCollection.document()
                    batch.setData(category, forDocument: categoryRef)
                }

                let defaultBalances = [
                    ["name": "Bank Card", "amount": 0.0],
                    ["name": "Cash", "amount": 0.0]
                ]

                let balancesCollection = userRef.collection("balances")
                for balance in defaultBalances {
                    let balanceRef = balancesCollection.document()
                    batch.setData(balance, forDocument: balanceRef)
                }

                // Step 5: Commit the batch
                batch.commit { batchError in
                    if let batchError = batchError {
                        completion(.failure(batchError))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }

    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
