import Foundation

struct AuthService {
    func login(email: String, password: String) throws -> User {
        // ダミー認証：固定の資格情報と照合
        guard email == AuthConstants.dummyEmail,
              password == AuthConstants.dummyPassword else {
            throw AuthError.invalidCredentials
        }
        return User(email: email)
    }
}
