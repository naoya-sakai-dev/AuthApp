import SwiftUI
import FirebaseCore

@main
struct AuthAppApp: App {
    @State private var appState: AppState

    init() {
        FirebaseApp.configure()
        _appState = State(initialValue: AppState())
    }

    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                HomeView()
                    .environment(appState)
            } else {
                LoginView()
                    .environment(appState)
            }
        }
    }
}
