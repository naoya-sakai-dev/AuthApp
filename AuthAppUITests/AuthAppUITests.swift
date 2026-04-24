import XCTest

final class AuthAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    // UI-01: 空欄のままログインボタンをタップするとエラーが表示される
    @MainActor
    func testEmptyFieldsShowValidationError() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["loginButton"].tap()

        XCTAssertTrue(app.staticTexts["emailError"].exists)
        XCTAssertTrue(app.staticTexts["passwordError"].exists)
    }

    // UI-02: 正しい資格情報を入力するとホーム画面に遷移する
    @MainActor
    func testValidLoginNavigatesToHome() throws {
        let app = XCUIApplication()
        app.launch()

        app.textFields["emailField"].tap()
        app.textFields["emailField"].typeText("user@example.com")

        app.secureTextFields["passwordField"].tap()
        app.secureTextFields["passwordField"].typeText("password123")

        app.buttons["loginButton"].tap()

        XCTAssertTrue(app.navigationBars["ホーム"].waitForExistence(timeout: 3))
    }

    // UI-03: ホーム画面でログアウトするとログイン画面に戻る
    @MainActor
    func testLogoutReturnsToLoginScreen() throws {
        let app = XCUIApplication()
        app.launch()

        app.textFields["emailField"].tap()
        app.textFields["emailField"].typeText("user@example.com")
        app.secureTextFields["passwordField"].tap()
        app.secureTextFields["passwordField"].typeText("password123")
        app.buttons["loginButton"].tap()

        XCTAssertTrue(app.navigationBars["ホーム"].waitForExistence(timeout: 3))
        app.buttons["ログアウト"].tap()

        XCTAssertTrue(app.buttons["loginButton"].waitForExistence(timeout: 2))
    }
}
