import FirebaseFirestore

class CategoryManager {
    static let shared = CategoryManager()
    private let db = Firestore.firestore()

    func fetchCategories(
        userId: String,
        completion: @escaping (Result<[Category], Error>) -> Void
    ) {
        db.collection("users").document(userId).collection("categories")
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else if let snapshot = snapshot {
                    let categories = snapshot.documents.map {
                        Category(id: $0.documentID, data: $0.data())
                    }
                    completion(.success(categories))
                }
            }
    }
    
    func addCategory(
        userId: String, category: Category,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.collection("users").document(userId).collection("categories")
            .addDocument(data: category.toDictionary()) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }

    func updateCategory(
        userId: String, category: Category,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.collection("users")
            .document(userId)
            .collection("categories")
            .document(category.id)
            .updateData(category.toDictionary()) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }

    func deleteCategory(
        userId: String, categoryId: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.collection("users")
            .document(userId)
            .collection("categories")
            .document(categoryId)
            .delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
    
    
}
