param(
  [string]$Distro = "Ubuntu-24.04",
  [string]$WslRepo = "~/vou-de-taxi"
)

$ErrorActionPreference = "Stop"

Write-Host "=== repo (Windows) ==="
try {
  $top = (git rev-parse --show-toplevel).Trim()
  Write-Host "topLevel=$top"
  Write-Host (git status -sb)
} catch {
  Write-Host "Nao consegui ler git repo neste terminal."
}

Write-Host ""
Write-Host "=== git safe.directory (Windows) ==="
try {
  git config --global --get-all safe.directory | ForEach-Object { "safe.directory=$_"}
} catch {}

Write-Host ""
Write-Host "=== docker (WSL) containers do stack ==="
wsl -d $Distro -- bash -lc "cd $WslRepo && docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}' | grep -E 'spark-' || true"

Write-Host ""
Write-Host "=== urls ==="
Write-Host "Spark UI:   http://localhost:8080"
Write-Host "Worker-1:   http://localhost:8081"
Write-Host "Worker-2:   http://localhost:8082"
Write-Host "Jupyter:    http://localhost:8888"
