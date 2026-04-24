import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @Environment(AppState.self) private var appState

    var body: some View {
        VStack(spacing: 24) {
            Text("AuthApp")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 16)

            // メールアドレス
            VStack(alignment: .leading, spacing: 4) {
                TextField("メールアドレス", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("emailField")
                if let error = viewModel.emailError {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .accessibilityIdentifier("emailError")
                }
            }

            // パスワード
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    if viewModel.isPasswordVisible {
                        TextField("パスワード", text: $viewModel.password)
                            .textFieldStyle(.roundedBorder)
                            .accessibilityIdentifier("passwordField")
                    } else {
                        SecureField("パスワード", text: $viewModel.password)
                            .textFieldStyle(.roundedBorder)
                            .accessibilityIdentifier("passwordField")
                    }
                    Button {
                        viewModel.isPasswordVisible.toggle()
                    } label: {
                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundStyle(.secondary)
                    }
                    .accessibilityIdentifier("passwordVisibilityToggle")
                }
                if let error = viewModel.passwordError {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .accessibilityIdentifier("passwordError")
                }
            }

            // 認証エラー
            if let authError = viewModel.authError {
                Text(authError)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .accessibilityIdentifier("authError")
            }

            // ログインボタン
            Button {
                viewModel.login(appState: appState)
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else {
                    Text("ログイン")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading)
            .accessibilityIdentifier("loginButton")
        }
        .padding(16)
    }
}

#Preview {
    LoginView()
        .environment(AppState())
}
