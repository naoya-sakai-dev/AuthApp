# AuthApp

iOS向けの認証フロー学習用アプリです。ログイン・ログアウト・セッション管理の基本的な仕組みをSwiftUI + MVVM + Firebase Authenticationで実装しています。

## 機能概要

| 機能 | 内容 |
|------|------|
| ログイン | メールアドレス・パスワードによるフォーム認証（Firebase Authentication） |
| バリデーション | 入力値のリアルタイムエラー表示 |
| セッション管理 | Firebaseによるトークン自動管理・アプリ再起動後の自動ログイン |
| ログアウト | Firebaseセッションの破棄とセッションリセット |

## 画面構成

- **LoginView** — メールアドレス・パスワード入力フォーム、ログインボタン
- **HomeView** — ログインユーザーのメールアドレス表示、ログアウトボタン

## アーキテクチャ

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
│   ├── AuthService.swift        # Firebase Authenticationによる認証ロジック
│   └── KeychainService.swift    # Keychain読み書き（旧実装・参照用）
└── Constants/
    └── AuthConstants.swift      # 定数管理
```

## 入力バリデーション

- メールアドレス未入力
- メールアドレスの形式不正（正規表現チェック）
- パスワード未入力

## セキュリティ設計

| 項目 | 対応内容 |
|------|---------|
| 認証 | Firebase Authentication（メール/パスワード） |
| トークン管理 | Firebaseによる自動管理・自動更新 |
| セッション永続化 | Firebase内部でのセキュアな保存 |
| 設定ファイル | `GoogleService-Info.plist` は `.gitignore` で除外 |

## 今後の実装予定

- [ ] 新規ユーザー登録フロー
- [ ] パスワードリセットフロー
- [ ] Sign in with Apple

## 動作環境

- iOS 17.0以上
- Xcode 15以上
- Swift 5.9以上
- Firebase iOS SDK（FirebaseAuth）
