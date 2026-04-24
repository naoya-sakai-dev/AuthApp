import Testing
@testable import AuthApp

// MARK: - LoginViewModel バリデーションテスト

@Suite("LoginViewModel バリデーション")
struct LoginViewModelValidationTests {

    // UT-01: メール空欄
    @Test func emailEmptyShowsError() {
        let vm = LoginViewModel()
        vm.email = ""
        vm.password = "password123"
        vm.login(appState: AppState())

        #expect(vm.emailError == AuthError.emptyEmail.message)
    }

    // UT-02: メール形式不正
    @Test func invalidEmailFormatShowsError() {
        let vm = LoginViewModel()
        vm.email = "invalid"
        vm.password = "password123"
        vm.login(appState: AppState())

        #expect(vm.emailError == AuthError.invalidEmailFormat.message)
    }

    // UT-03: メール正常
    @Test func validEmailNoError() {
        let vm = LoginViewModel()
        vm.email = "user@example.com"
        vm.password = "password123"
        vm.login(appState: AppState())

        #expect(vm.emailError == nil)
    }

    // UT-04: パスワード空欄
    @Test func passwordEmptyShowsError() {
        let vm = LoginViewModel()
        vm.email = "user@example.com"
        vm.password = ""
        vm.login(appState: AppState())

        #expect(vm.passwordError == AuthError.emptyPassword.message)
    }

    // UT-05: パスワード正常
    @Test func validPasswordNoError() {
        let vm = LoginViewModel()
        vm.email = "user@example.com"
        vm.password = "password123"
        vm.login(appState: AppState())

        #expect(vm.passwordError == nil)
    }
}

// MARK: - KeychainService セッション管理テスト

@Suite("KeychainService セッション管理")
struct KeychainServiceTests {

    // テスト用に別キーを使い、アプリ本体の Keychain を汚染しない
    private let testKey = "test_auth_token"

    // UT-09: トークン保存後に読み込めること
    @Test func saveAndLoadToken() {
        let keychain = KeychainService()
        keychain.saveToken("test_token")

        #expect(keychain.loadToken() == "test_token")

        keychain.deleteToken() // 後片付け
    }

    // UT-10: トークン削除後は nil が返ること（ログアウト後にセッションが消えること）
    @Test func deleteTokenReturnsNil() {
        let keychain = KeychainService()
        keychain.saveToken("test_token")
        keychain.deleteToken()

        #expect(keychain.loadToken() == nil)
    }

    // UT-11: AppState 初期化時に Keychain のトークンが存在すれば isLoggedIn が true になること
    @Test func appStateInitWithTokenIsLoggedIn() {
        let keychain = KeychainService()
        keychain.saveToken("test_token") // 事前にトークンを保存

        let appState = AppState()
        #expect(appState.isLoggedIn == true)

        keychain.deleteToken() // 後片付け
    }

    // UT-12: AppState 初期化時に Keychain にトークンがなければ isLoggedIn が false になること
    @Test func appStateInitWithoutTokenIsNotLoggedIn() {
        let keychain = KeychainService()
        keychain.deleteToken() // 事前にトークンを削除

        let appState = AppState()
        #expect(appState.isLoggedIn == false)
    }
}

// MARK: - AuthService 認証テスト

@Suite("AuthService ダミー認証")
struct AuthServiceTests {

    // UT-06: 正しい資格情報でログイン成功
    @Test func loginWithCorrectCredentialsReturnsUser() throws {
        let service = AuthService()
        let user = try service.login(
            email: AuthConstants.dummyEmail,
            password: AuthConstants.dummyPassword
        )
        #expect(user.email == AuthConstants.dummyEmail)
    }

    // UT-07: パスワード誤りでエラー
    @Test func loginWithWrongPasswordThrows() {
        let service = AuthService()
        #expect(throws: AuthError.invalidCredentials) {
            try service.login(email: AuthConstants.dummyEmail, password: "wrong")
        }
    }

    // UT-08: メール誤りでエラー
    @Test func loginWithWrongEmailThrows() {
        let service = AuthService()
        #expect(throws: AuthError.invalidCredentials) {
            try service.login(email: "wrong@example.com", password: AuthConstants.dummyPassword)
        }
    }
}
