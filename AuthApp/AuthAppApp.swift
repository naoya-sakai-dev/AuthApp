import SwiftUI

@main
struct AuthAppApp: App {
    @State private var appState = AppState()

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
