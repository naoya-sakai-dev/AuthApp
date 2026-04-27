import Foundation

enum AuthError: Error {
    case invalidCredentials
    case emptyEmail
    case invalidEmailFormat
    case emptyPassword
    case unknown

    var message: String {
        switch self {
        case .invalidCredentials: return "メールアドレスまたはパスワードが違います"
        case .emptyEmail:         return "メールアドレスを入力してください"
        case .invalidEmailFormat: return "メールアドレスの形式が正しくありません"
        case .emptyPassword:      return "パスワードを入力してください"
        case .unknown:            return "予期しないエラーが発生しました"
        }
    }
}
