---
title: 09 PlantUML
tags: [sandbox]
---

# 09 PlantUML

Growi で常用されている PlantUML が両 SSG で描画できるか検証する。

## Sequence

```plantuml
@startuml
Alice -> Bob: 認証要求
Bob --> Alice: チャレンジ
Alice -> Bob: レスポンス
Bob --> Alice: OK
@enduml
```

## Use Case

```plantuml
@startuml
left to right direction
actor 利用者 as user
rectangle 社内ポータル {
  user --> (ログイン)
  user --> (ドキュメント閲覧)
  user --> (議事録投稿)
}
@enduml
```

## Class

```plantuml
@startuml
class User {
  +id: String
  +email: String
  +login()
}
class Session {
  +id: String
  +expiresAt: DateTime
}
User "1" *-- "many" Session
@enduml
```

## 検証ポイント

- Quartz: `remark-plantuml` 系プラグインでサーバレンダリングされるか
- MkDocs: `plantuml-markdown` 拡張でレンダリングされるか
- PlantUML サーバ: `www.plantuml.com/plantuml`（比較フェーズのみ。本番は社内サーバ検討）
