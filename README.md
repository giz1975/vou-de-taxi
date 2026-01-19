# vou de taxi

PySpark pipeline using NYC Taxi & Limousine Commission (TLC) public trip records.

Goal: demonstrate an incremental and idempotent pipeline:
**ingest -> clean -> enrich -> eda -> model -> export**.

> Data is NOT versioned in Git. This repo contains only code and documentation.

## Environment (repro)
- Windows 11 + WSL2 (Ubuntu 24.04)
- Docker Desktop with WSL integration
- VS Code + Python and Jupyter extensions

Recommended: 16GB RAM minimum (32GB ideal) and 4+ vCPUs.

## Start local Spark cluster
In WSL:

  cd ~/vou-de-taxi
  docker compose up -d
  docker compose ps

UIs:
- Spark Master: http://localhost:8080
- Workers: http://localhost:8081 and http://localhost:8082
- JupyterLab: http://localhost:8888/lab?token=spark

## Data layout (outside Git)
data/raw, data/silver, data/gold (partitioned by year/month).

## License
MIT
