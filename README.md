# vou-de-taxi

PySpark pipeline using NYC Taxi & Limousine Commission (TLC) public trip records.

Goal: demonstrate an incremental and idempotent pipeline:
**ingest -> clean -> enrich -> eda -> model -> export**.

> Data is NOT versioned in Git. This repo contains only code and documentation.

## Environment (repro)

- Windows 11 + WSL2 (Ubuntu 24.04)
- Docker Desktop with WSL integration
- VS Code + Python and Jupyter extensions

Recommended: 16GB RAM minimum (32GB ideal) and 4+ vCPUs.

> Source of truth for this dev environment: [`docs/ambiente.md`](docs/ambiente.md)

## Start local Spark cluster

### In WSL

```bash
cd ~/vou-de-taxi
docker compose up -d
```

### From Windows (PowerShell)

```powershell
wsl -d Ubuntu-24.04 -- bash -lc "cd ~/vou-de-taxi && docker compose up -d"
```

### Quick status (recommended)

```powershell
.\scripts\status.ps1
```

UIs:
- Spark Master: http://localhost:8080
- Workers: http://localhost:8081 and http://localhost:8082
- JupyterLab: http://localhost:8888/lab?token=spark

## Examples

### Run a sample job (wordcount)

```powershell
wsl -d Ubuntu-24.04 -- bash -lc "docker exec -it spark-master /opt/spark/bin/spark-submit --master spark://spark-master:7077 /opt/spark/work-dir/apps/wordcount.py"
```

### Notebook

- `apps/notebooks/nyc_taxi_01_read.ipynb`

Inside the Jupyter container, the repo mounts are available at:
- `/home/jovyan/apps`
- `/home/jovyan/data`

## Data layout (outside Git)

Suggested layout (not versioned):
- `data/raw`
- `data/silver`
- `data/gold` (partitioned by year/month)

## Git + \\wsl$ note (Windows)

If you use Git for Windows through `\\wsl$\...` and hit `dubious ownership`, apply:

```powershell
git config --global --add safe.directory "%(prefix)///wsl$/Ubuntu-24.04/home/gabriel/vou-de-taxi"
```

## License

MIT
