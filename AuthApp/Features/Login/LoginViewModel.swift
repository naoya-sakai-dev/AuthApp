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

        // ダミー認証のため同期処理（実務では async/await を使用）
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [self] in
            do {
                let user = try authService.login(email: email, password: password)
                appState.login(user: user)
            } catch let error as AuthError {
                authError = error.message
            } catch {
                authError = "予期しないエラーが発生しました"
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
