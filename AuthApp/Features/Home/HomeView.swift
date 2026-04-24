import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("ようこそ！")
                    .font(.title2)
                Text(appState.currentUser?.email ?? "")
                    .foregroundStyle(.secondary)

                Button("ログアウト", role: .destructive) {
                    appState.logout()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .navigationTitle("ホーム")
        }
    }
}

#Preview {
    let state = AppState()
    state.currentUser = User(email: "user@example.com")
    return HomeView().environment(state)
}
