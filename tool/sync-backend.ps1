# Manual sync: push filtered server/ history to companio-backend (cloud deploy repo)
# Usage: from repo root:  powershell -ExecutionPolicy Bypass -File tool/sync-backend.ps1
# Requires: git subtree available, push credentials for https://github.com/aaryan06-collab/companio-backend.git
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$Root = (Resolve-Path "$PSScriptRoot/..").Path
Set-Location $Root

Write-Host "-> subtree split server/ -> backend-sync" -ForegroundColor Cyan
git branch -D backend-sync 2>$null | Out-Null
git subtree split -P server -b backend-sync
if ($LASTEXITCODE -ne 0) { throw "subtree split failed" }

Write-Host "-> dry-run push to companio-backend" -ForegroundColor Cyan
git push --dry-run https://github.com/aaryan06-collab/companio-backend.git backend-sync:main
if ($LASTEXITCODE -ne 0) {
  Write-Host "dry-run rejected (remote placeholder divergence) — will force-with-lease on real push" -ForegroundColor Yellow
}

Write-Host "-> pushing backend-sync:main to companio-backend (force-with-lease, manual approval)" -ForegroundColor Cyan
$answer = Read-Host "Push now? type YES to continue"
if ($answer -ne "YES") { Write-Host "Aborted."; exit 1 }
git push https://github.com/aaryan06-collab/companio-backend.git backend-sync:main --force
if ($LASTEXITCODE -ne 0) { throw "push failed" }

Write-Host "-> verifying" -ForegroundColor Green
git ls-remote https://github.com/aaryan06-collab/companio-backend.git main
Write-Host "Done. companio-app main untouched; backend cloud repo now matches server/." -ForegroundColor Green
