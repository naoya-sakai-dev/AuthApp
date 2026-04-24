import Foundation
import Security

struct KeychainService {

    // kSecAttrService でアプリを一意に識別する
    // これがないと別アプリや別エントリと衝突して保存・読み込みが失敗することがある
    private let service = "com.authapp.keychain"

    // トークンを Keychain に保存する
    // 既存のエントリを一度削除してから追加することで、重複登録を防ぐ
    func saveToken(_ token: String) {
        let data = Data(token.utf8)
        let query: [String: Any] = [
            kSecClass as String:       kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: AuthConstants.keychainKey,
            kSecValueData as String:   data
        ]
        SecItemDelete(query as CFDictionary) // 既存エントリを削除
        SecItemAdd(query as CFDictionary, nil)
    }

    // Keychain からトークンを読み込む
    // 取得できない場合（未ログイン・削除済み）は nil を返す
    func loadToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String:       kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: AuthConstants.keychainKey,
            kSecReturnData as String:  true,
            kSecMatchLimit as String:  kSecMatchLimitOne
        ]
        var result: AnyObject?
        guard SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess,
              let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    // Keychain からトークンを削除する（ログアウト時に呼ぶ）
    func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String:       kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: AuthConstants.keychainKey
        ]
        SecItemDelete(query as CFDictionary)
    }
}
