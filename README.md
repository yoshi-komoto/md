# md — 社内ナレッジベース

Obsidian vault を 2 種類の SSG（Quartz v4 / MkDocs Material）でレンダリングし、社内向けに並行公開するリポジトリ。Growi からの移行先を比較検証中。

- 設計: [`docs/superpowers/specs/2026-04-13-obsidian-rendering-design.md`](docs/superpowers/specs/2026-04-13-obsidian-rendering-design.md)
- 実装プラン: [`docs/superpowers/plans/2026-04-13-obsidian-rendering-implementation.md`](docs/superpowers/plans/2026-04-13-obsidian-rendering-implementation.md)

## 公開 URL

- 比較トップ: `https://<org>.github.io/md/`
- Quartz 版: `https://<org>.github.io/md/quartz/`
- MkDocs 版: `https://<org>.github.io/md/mkdocs/`

（GitHub Organization のメンバーのみアクセス可。Google Workspace SSO 経由。）

## リポジトリ構成

```
vault/                   # Obsidian vault（ソース・オブ・トゥルース）
sites/quartz/            # Quartz v4 設定・依存
sites/mkdocs/            # MkDocs Material 設定・依存
sites/landing/           # 比較ランディング
scripts/                 # PowerShell 補助スクリプト
.github/workflows/       # CI / Pages デプロイ
docs/superpowers/        # 設計書・実装プラン・比較結果
```

## セットアップ (Windows 11 + PowerShell 7)

### 前提

1. Git for Windows で symlink を有効化:
   ```powershell
   git config --global core.symlinks true
   ```
2. Developer Mode 有効化（Settings → For developers → Developer Mode）
3. Node.js 22 (Quartz 用)
4. Docker Desktop (MkDocs ローカルプレビュー用。Python 非インストール前提)
5. Obsidian

### 初回セットアップ

```powershell
git clone https://github.com/yoshi-komoto/md.git
cd md

# symlink 作成
pwsh ./scripts/setup-symlinks.ps1

# Quartz 依存インストール
cd sites/quartz; npm ci; cd ../..

# MkDocs は Docker 経由のため追加インストール不要
```

### ローカルプレビュー

```powershell
# 両方起動
pwsh ./scripts/preview.ps1

# 個別起動
pwsh ./scripts/preview.ps1 -Target quartz   # http://localhost:8080
pwsh ./scripts/preview.ps1 -Target mkdocs   # http://localhost:8000
```

### Obsidian での編集

Obsidian で `vault/` フォルダを開く。保存は両プレビューへ即反映される（symlink 経由）。

## 執筆ガイド

- `vault/00-Guide/welcome.md` を起点に読み進めてください
- 記法の詳細は `vault/00-Guide/markdown-guide.md`
- 記法サンプルは `vault/90-Sandbox/` を参照

## CI / デプロイ

- PR 時: `.github/workflows/ci.yml` が両 SSG のビルドを検証
- `master` push 時: `.github/workflows/pages.yml` が `_site/` を組み立てて GitHub Pages にデプロイ

## 初期セットアップ（GitHub Pages 側、Admin 操作）

1. Repository → Settings → Pages → Source: **GitHub Actions**
2. Organization → Settings → Policies → Pages: **Private を有効化**
3. Repository → Settings → Pages → Visibility: **Private**

## 比較・採用決定の流れ

1. 両サイトを閲覧し、設計書 §9 の評価観点に沿って評価
2. 結果を `docs/superpowers/comparison/YYYY-MM-DD-result.md` に記録
3. 採用 SSG を決定
4. 不採用側の `sites/<不採用>/` と関連 workflow を削除

## Growi からの移行メモ

- パスリンク `[/path]` → `[[path|表示名]]`
- PlantUML フェンス → `` ```plantuml `` フェンス
- 画像は `vault/_attachments/` 配下に配置し `![[...]]` で参照
- 詳細は `vault/90-Sandbox/16-growi-migration.md`

## トラブルシュート

| 症状 | 対処 |
|---|---|
| symlink が壊れている | `pwsh ./scripts/setup-symlinks.ps1 -Force` |
| Quartz build でモジュール未検出 | symlink を再作成 |
| MkDocs build でプラグイン未検出 | `sites/mkdocs/requirements.txt` のバージョンを最新に更新 |
| CI で symlink が効かない | workflow 内で `ln -s` により再作成しているか確認 |
| Pages が 404 | Org 側で Pages が有効、Source が GitHub Actions か確認 |
