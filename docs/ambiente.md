# Mapa do Ambiente — Projeto "vou de taxi"

## Objetivo
Fonte única de verdade do ambiente de desenvolvimento para gerar scripts precisos e reduzir erro por caminho/pasta/configuração.

## Caminhos (fonte de verdade)
- Repo (WSL): /home/gabriel/vou-de-taxi
- Repo (Windows via UNC): \\wsl$\Ubuntu-24.04\home\gabriel\vou-de-taxi

## Snapshots gerados
- Windows: docs/ambiente.snapshot.windows.json
- WSL: docs/ambiente.snapshot.wsl.txt

## Host (Windows)
- Windows 11 Pro 64-bit (10.0.26200, Build 26200)
- Usuário: gabri
- PowerShell: 5.1.x
- VS Code: 1.108.1
- Git for Windows: 2.52.0.windows.1
- Python: 3.14.2
- Docker Desktop: 4.56.0
- Docker engine: 29.1.3 (context desktop-linux)
- Docker Compose: v5.0.0-desktop.1
- WSL: 2.6.3 (kernel 6.6.87.2-1)

## Git (Windows acessando repo no WSL via \\wsl$)
### Problema conhecido
Ao usar Git for Windows no caminho \\wsl$\..., pode ocorrer:
fatal: detected dubious ownership

### Correção aplicada (obrigatória neste ambiente)
Rodar uma vez no PowerShell do Windows:
git config --global --add safe.directory "%(prefix)///wsl$/Ubuntu-24.04/home/gabriel/vou-de-taxi"

## WSL
- Distro: Ubuntu-24.04 (WSL2)
- Usuário: gabriel
- Repo: /home/gabriel/vou-de-taxi

## Stack do projeto (Docker Compose)
### Fonte de verdade
Arquivo: /home/gabriel/vou-de-taxi/docker-compose.yml

### Serviços / imagens
- spark-master: spark:3.5.0-java17-python3
- spark-worker-1: spark:3.5.0-java17-python3
- spark-worker-2: spark:3.5.0-java17-python3
- spark-jupyter: jupyter/pyspark-notebook:spark-3.5.0

### Portas
- spark-master: 7077 (cluster), 8080 (UI)
- spark-worker-1: 8081 (UI)
- spark-worker-2: 8082 (UI)
- spark-jupyter: 8888 (Jupyter)

### Volumes (no repo)
- ./apps e ./data montados nos containers
  - Spark: /opt/spark/work-dir/apps e /opt/spark/work-dir/data
  - Jupyter: /home/jovyan/apps e /home/jovyan/data (e também /opt/spark/work-dir/apps|data)

### Token Jupyter (estado atual)
- JUPYTER_TOKEN está definido no docker-compose.yml como "spark".
Recomendação: mover para arquivo .env (não versionado) e manter um .env.example.

### URLs úteis
- Spark UI (master): http://localhost:8080
- Worker-1 UI: http://localhost:8081
- Worker-2 UI: http://localhost:8082
- Jupyter: http://localhost:8888

## Comandos canônicos (Windows PowerShell)
### Subir stack
wsl -d Ubuntu-24.04 -- bash -lc "cd ~/vou-de-taxi && docker compose up -d"

### Ver status (evita bug de CR/LF em scripts longos)
wsl -d Ubuntu-24.04 -- bash -lc "cd ~/vou-de-taxi && docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}' | grep -E 'spark-' || true"

### Derrubar stack
wsl -d Ubuntu-24.04 -- bash -lc "cd ~/vou-de-taxi && docker compose down"

### Reset seguro (remove conflitos de nome e sobe limpo)
wsl -d Ubuntu-24.04 -- bash -lc "docker rm -f spark-master spark-worker-1 spark-worker-2 spark-jupyter 2>/dev/null || true; cd ~/vou-de-taxi && docker compose up -d"
