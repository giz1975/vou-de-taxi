#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$HOME/vou-de-taxi}"
OUTDIR="$REPO_DIR/docs"
mkdir -p "$OUTDIR"
OUT="$OUTDIR/ambiente.snapshot.wsl.txt"

cmdv() { command -v "$1" >/dev/null 2>&1; }

{
  echo "=== timestamp ==="; date -Is
  echo
  echo "=== repo ==="
  echo "REPO_DIR=$REPO_DIR"
  if [ -d "$REPO_DIR/.git" ]; then
    git -C "$REPO_DIR" rev-parse --show-toplevel || true
    git -C "$REPO_DIR" branch --show-current || true
    git -C "$REPO_DIR" log -1 --oneline || true
    git -C "$REPO_DIR" remote -v || true
    git -C "$REPO_DIR" status -sb || true
  else
    echo "OBS: $REPO_DIR nao parece ser um repo git (nao achei .git)."
  fi

  echo
  echo "=== OS / Kernel ==="
  cat /etc/os-release || true
  echo
  uname -a || true
  echo
  echo "proc/version:"; cat /proc/version || true

  echo
  echo "=== Tooling (WSL) ==="
  cmdv git && git --version || true
  cmdv docker && docker --version || true
  cmdv docker && docker version || true
  cmdv docker && docker compose version || true
  cmdv python3 && python3 --version || true
  cmdv python && python --version || true
  cmdv uv && uv --version || true
  cmdv ruff && ruff --version || true
  cmdv pytest && pytest --version || true
  cmdv java && java -version || true

  echo
  echo "=== Networking (WSL) ==="
  cmdv ip && ip a || true
  echo
  cmdv ip && ip route || true
  echo
  cmdv ss && ss -lntp || true

  echo
  echo "=== Compose (vou-de-taxi) ==="
  cd "$REPO_DIR"
  docker compose ps || true
  echo
  docker compose config || true
} > "$OUT"

echo "OK -> $OUT"
