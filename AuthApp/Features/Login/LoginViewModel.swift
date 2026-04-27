import SwiftUI

@Observable
final class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var isPasswordVisible: Bool = false
    var isLoading: Bool = false
    var emailError: String? = nil
    var passwordError: String? = nil
    var authError: String? = nil

    private let authService = AuthService()

    func login(appState: AppState) {
        guard validate() else { return }

        isLoading = true
        authError = nil

        Task { @MainActor in
            do {
                let user = try await authService.login(email: email, password: password)
                appState.login(user: user)
            } catch let error as AuthError {
                authError = error.message
            } catch {
                authError = AuthError.unknown.message
            }
            isLoading = false
        }
    }

    private func validate() -> Bool {
        emailError = nil
        passwordError = nil

        if email.isEmpty {
            emailError = AuthError.emptyEmail.message
        } else if !isValidEmail(email) {
            emailError = AuthError.invalidEmailFormat.message
        }

        if password.isEmpty {
            passwordError = AuthError.emptyPassword.message
        }

        return emailError == nil && passwordError == nil
    }

    private func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }
}
