import Foundation
import FirebaseAuth

struct AuthService {
    func login(email: String, password: String) async throws -> User {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return User(email: result.user.email ?? "")
        } catch let error as NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .wrongPassword, .userNotFound, .invalidEmail, .invalidCredential:
                throw AuthError.invalidCredentials
            default:
                throw AuthError.unknown
            }
        }
    }

    func logout() throws {
        try Auth.auth().signOut()
    }
}
