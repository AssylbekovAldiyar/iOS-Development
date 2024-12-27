import FirebaseAuth
import FirebaseFirestore

class UserManager {
    static let shared = UserManager()
    private let db = Firestore.firestore()
    func updateUser() {
        if let user = Auth.auth().currentUser {
            let userId = user.uid
            let email = user.email
            let name = user.displayName

            let userRef = db.collection("users").document(userId)

            userRef.setData([
                "email": email ?? "",
                "name": name ?? "Unnamed",
            ]) { error in
                if let error = error {
                    print(
                        "Ошибка добавления пользователя в Firestore: \(error.localizedDescription)"
                    )
                } else {
                    print("Пользователь успешно добавлен/обновлен в Firestore")
                }
            }
        }

    }
    
    func getUser() -> User? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        
        return user
    }
}
