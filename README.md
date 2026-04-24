# AuthApp

iOS向けの認証フロー学習用アプリです。ログイン・ログアウト・セッション管理の基本的な仕組みをSwiftUI + MVVMアーキテクチャで実装しています。

## 現在の仕様

### 機能概要

| 機能 | 内容 |
|------|------|
| ログイン | メールアドレス・パスワードによるフォーム認証 |
| バリデーション | 入力値のリアルタイムエラー表示 |
| セッション管理 | Keychainへのトークン保存・アプリ再起動後の自動ログイン |
| ログアウト | Keychainからのトークン削除とセッションリセット |

### 画面構成

- **LoginView** — メールアドレス・パスワード入力フォーム、ログインボタン
- **HomeView** — ログインユーザーのメールアドレス表示、ログアウトボタン

### アーキテクチャ

```
AuthApp/
├── App/
│   └── AppState.swift          # ログイン状態・ユーザー情報のグローバル管理（@Observable）
├── Features/
│   ├── Login/
│   │   ├── LoginView.swift      # ログイン画面UI
│   │   └── LoginViewModel.swift # 入力値管理・バリデーション・認証呼び出し
│   └── Home/
│       └── HomeView.swift       # ホーム画面UI
├── Models/
│   ├── User.swift               # ユーザーモデル
│   └── AuthError.swift          # 認証エラー定義
├── Services/
│   ├── AuthService.swift        # 認証ロジック（現在はダミー実装）
│   └── KeychainService.swift    # Keychain読み書き
└── Constants/
    └── AuthConstants.swift      # ダミー認証情報・Keychainキー定数
```

### 現在の認証方式（ダミー実装）

現在の`AuthService`は固定の資格情報と照合するダミー実装です。

| 項目 | 値 |
|------|----|
| メールアドレス | `user@example.com` |
| パスワード | `password123` |

### 入力バリデーション

- メールアドレス未入力
- メールアドレスの形式不正（正規表現チェック）
- パスワード未入力

## 今後の実装予定

現在はダミー認証ですが、以下の実際の認証機能への置き換えを予定しています。

- [ ] バックエンドAPIとの通信による実認証（async/await）
- [ ] JWTトークンの取得・保存・更新処理
- [ ] 新規ユーザー登録フロー
- [ ] パスワードリセットフロー
- [ ] Sign in with Apple / Googleによるソーシャル認証

## 動作環境

- iOS 17.0以上
- Xcode 15以上
- Swift 5.9以上
