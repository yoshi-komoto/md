#Requires -Version 7
<#
.SYNOPSIS
    sites/quartz/content と sites/mkdocs/docs を vault/ への symlink として作成する。
.DESCRIPTION
    Windows では symlink の作成に Developer Mode 有効化または管理者権限が必要。
    Git 側では `git config --global core.symlinks true` を推奨。
#>

[CmdletBinding()]
param(
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$vaultAbs = Join-Path $repoRoot 'vault'

if (-not (Test-Path $vaultAbs)) {
    throw "vault/ が見つかりません: $vaultAbs"
}

$targets = @(
    @{ Link = (Join-Path $repoRoot 'sites/quartz/content'); Target = '../../vault' },
    @{ Link = (Join-Path $repoRoot 'sites/mkdocs/docs');    Target = '../../vault' }
)

foreach ($t in $targets) {
    $linkPath = $t.Link
    $target   = $t.Target
    $parent   = Split-Path -Parent $linkPath
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
    }

    if (Test-Path $linkPath) {
        $item = Get-Item $linkPath -Force
        if ($item.LinkType -eq 'SymbolicLink') {
            Write-Host "既に symlink が存在: $linkPath -> $($item.Target)"
            if (-not $Force) { continue }
            Remove-Item $linkPath -Force
        } elseif ($Force) {
            Write-Warning "実体ディレクトリ/ファイルが存在。-Force により削除: $linkPath"
            Remove-Item $linkPath -Recurse -Force
        } else {
            throw "$linkPath は symlink でなく実体です。-Force を指定して再実行してください。"
        }
    }

    try {
        New-Item -ItemType SymbolicLink -Path $linkPath -Target $target -Force | Out-Null
        Write-Host "created: $linkPath -> $target"
    } catch {
        Write-Error "symlink 作成失敗: $linkPath"
        Write-Error "Developer Mode が有効か、または管理者として実行しているか確認してください。"
        throw
    }
}

Write-Host "完了: symlink を作成しました。"
