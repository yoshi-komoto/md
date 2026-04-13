---
title: 11 表
tags: [sandbox]
---

# 11 表

## 基本

| 項目 | 値 | 備考 |
|---|---|---|
| A | 100 | 標準 |
| B | 200 | オプション |
| C | 300 | 拡張 |

## アライメント指定

| 左寄せ | 中央 | 右寄せ |
|:---|:---:|---:|
| apple | 100 | 1.5 |
| banana | 20 | 12.5 |
| cherry | 3 | 125.5 |

## 広めの表

| コンポーネント | 責務 | 依存先 | 備考 |
|---|---|---|---|
| API Gateway | 認証・ルーティング | IdP | OIDC |
| Auth Service | トークン管理 | DB, Cache | JWT |
| User Service | ユーザー CRUD | DB | |
| Notification | 通知配信 | Queue, Email | 非同期 |

## 検証ポイント

- アライメントが効くか
- 横スクロール or 折り返しの挙動
