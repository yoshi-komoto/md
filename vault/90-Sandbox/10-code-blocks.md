---
title: 10 コードブロック
tags: [sandbox]
---

# 10 コードブロック

## TypeScript

```typescript
interface User {
  id: string;
  email: string;
}

async function fetchUser(id: string): Promise<User> {
  const res = await fetch(`/api/users/${id}`);
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}
```

## Python

```python
from dataclasses import dataclass

@dataclass
class User:
    id: str
    email: str

def greet(user: User) -> str:
    return f"Hello, {user.email}"
```

## Bash

```bash
#!/usr/bin/env bash
set -euo pipefail

for f in vault/**/*.md; do
  echo "Processing $f"
done
```

## Diff

```diff
 function add(a, b) {
-  return a + b
+  return a + b + 0  // noop
 }
```

## 言語指定なし

```
素のテキスト。
半角スペース        保持される。
```

## 長いコード（横スクロール検証）

```javascript
const veryLongLine = "This is a deliberately long line to test how the rendered site handles horizontal overflow. It should probably wrap or add a horizontal scrollbar. Let us see how each SSG handles this situation in practice.";
```

## 検証ポイント

- シンタックスハイライト有無（6 言語）
- 横スクロール挙動
- コピーボタンの有無
