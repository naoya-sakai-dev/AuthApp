import SwiftUI
import FirebaseAuth

@Observable
final class AppState {
    var isLoggedIn: Bool = false
    var currentUser: User?

    init() {
        if let firebaseUser = Auth.auth().currentUser {
            isLoggedIn = true
            currentUser = User(email: firebaseUser.email ?? "")
        }
    }

    func login(user: User) {
        currentUser = user
        isLoggedIn = true
    }

    func logout() {
        try? Auth.auth().signOut()
        currentUser = nil
        isLoggedIn = false
    }
}
