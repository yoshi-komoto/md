---
title: Observability 基本
tags: [knowledge, observability]
---

# Observability 基本

3 本柱: メトリクス / ログ / トレース。

## メトリクス

- 4 つのゴールデンシグナル: Latency, Traffic, Errors, Saturation
- ヒストグラム（p50/p95/p99）を重視

## ログ

- 構造化ログ（JSON）
- trace_id を必ず含める

## トレース

- OpenTelemetry を採用
- 分散システムでの依存把握に有効

関連: [[api-design-principles]]
