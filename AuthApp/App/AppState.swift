import SwiftUI

@Observable
final class AppState {
    var isLoggedIn: Bool = false
    var currentUser: User?

    private let keychain = KeychainService()

    init() {
        isLoggedIn = keychain.loadToken() != nil
    }

    func login(user: User) {
        keychain.saveToken(user.email)
        currentUser = user
        isLoggedIn = true
    }

    func logout() {
        keychain.deleteToken()
        currentUser = nil
        isLoggedIn = false
    }
}
