---
title: API 設計原則
tags: [knowledge, api]
---

# API 設計原則

## 基本方針

- リソース指向 URL
- HTTP メソッドで動詞を表現（GET/POST/PUT/PATCH/DELETE）
- バージョンは URL パス `/v1/...`
- エラーは RFC 7807 (Problem Details) 形式

## ページング

- cursor ベース推奨。offset ベースはデータ整合性が崩れやすい

## 関連

- [[code-review-checklist]]
- [[observability-basics]]
