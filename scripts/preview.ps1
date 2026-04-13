#Requires -Version 7
<#
.SYNOPSIS
    Quartz と MkDocs のローカルプレビューを同時起動する。
.DESCRIPTION
    Quartz: Node.js で localhost:8080
    MkDocs: Docker で localhost:8000（ローカル Python 非前提）
#>

[CmdletBinding()]
param(
    [ValidateSet('both','quartz','mkdocs')]
    [string]$Target = 'both'
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

function Start-Quartz {
    $quartzDir = Join-Path $repoRoot 'sites/quartz'
    if (-not (Test-Path (Join-Path $quartzDir 'package.json'))) {
        Write-Warning "Quartz 未初期化。Task 11 を先に実施してください。"
        return
    }
    Write-Host "Starting Quartz on http://localhost:8080 ..."
    Start-Process pwsh -ArgumentList "-NoExit","-Command","cd '$quartzDir'; npx quartz build --serve"
}

function Start-MkDocs {
    $mkdocsDir = Join-Path $repoRoot 'sites/mkdocs'
    if (-not (Test-Path (Join-Path $mkdocsDir 'mkdocs.yml'))) {
        Write-Warning "MkDocs 未初期化。Task 12 を先に実施してください。"
        return
    }
    $dockerCheck = Get-Command docker -ErrorAction SilentlyContinue
    if (-not $dockerCheck) {
        Write-Warning "Docker が見つかりません。MkDocs のローカルプレビューには Docker が必要です。"
        return
    }
    Write-Host "Starting MkDocs on http://localhost:8000 (via Docker) ..."
    $repoMount = $repoRoot -replace '\\','/'
    Start-Process pwsh -ArgumentList "-NoExit","-Command","docker run --rm -it -p 8000:8000 -v '${repoMount}:/workspace' -w /workspace/sites/mkdocs squidfunk/mkdocs-material:latest serve -a 0.0.0.0:8000"
}

if ($Target -in 'both','quartz') { Start-Quartz }
if ($Target -in 'both','mkdocs') { Start-MkDocs }

Write-Host ""
Write-Host "プレビューは別ウィンドウで起動しました。停止するには各ウィンドウで Ctrl+C。"
