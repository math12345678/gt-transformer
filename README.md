# GT-Transformer & Ground Truth Workbench

Unified repository for **GT-Transformer**: both the front-facing React/Three.js web portal (`frontend/`, deployed to GitHub Pages) and the FastAPI/JAX recombination detection workbench (deployed at root via Docker).

## Live URLs

- **Landing UI (GitHub Pages):** https://math12345678.github.io/gt-transformer/
- **Live Workbench App:** https://gt-transformer-prod-061ed.containers.snapdeploy.app/

All launch links in the landing UI point directly to the live workbench, while pushes to `main` automatically build and deploy `frontend/` to GitHub Pages via `.github/workflows/pages.yml`.

## Requirements

- **Backend / Workbench:** Python 3.10+ and `pip` (optional: Docker; optional: Supabase/Postgres DSN; optional: AI assistant API key)
- **Front-Facing UI (`frontend/`):** Node.js 20+ and `npm`

## Running the Front-Facing UI Locally

```bash
cd frontend
npm ci
npm run dev          # Starts Vite dev server at http://localhost:3000
```

Other frontend scripts:

```bash
npm run lint         # TypeScript check (tsc --noEmit)
npm run build        # Builds static bundle into frontend/dist/
npm run preview      # Serves built frontend bundle locally
npx tsx --test src/utils/genomeScan.test.ts src/utils/themeAndGlossary.test.ts
```

## Running the Workbench Locally

From the repository root:

```bash
python3 -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

Configuration is optional. To customize environment variables, copy `.env.example` (never commit `.env`):

```bash
cp .env.example .env
```

Main optional settings in `.env`:

- `SUPABASE_DB_DSN`: Postgres connection string for shared runs and accounts (defaults to local `recomb_app.db` SQLite if omitted).
- `AI_PROVIDER` and `ANTHROPIC_API_KEY`: enable the AI results assistant (`ANTHROPIC_MODEL` sets the model).
- `ADMIN_USERNAME` and `ADMIN_PASSWORD`: admin login for the deployed workbench.
- `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`, and `GOOGLE_REDIRECT_URI`: optional Google sign-in.

Start the FastAPI workbench server:

```bash
./run_server.sh                    # http://127.0.0.1:8050 (healthz at /healthz)
```

Or launch on a custom port / directly via `uvicorn`:

```bash
PORT=9000 ./run_server.sh
python3 -m uvicorn app:app --host 127.0.0.1 --port 8050
```

## Using the Workbench

1. Click **Open** and choose an aligned FASTA file (or paste one directly): 5–500 sequences, up to 50,000 columns, 20 MB upload limit.
2. Open **Options** to pick the checkpoint (`ckpt_N40000`, `ckpt_N10000`, `ckpt_N10000_extreme`, `ckpt_N10000_v2`) and scoring mode.
3. Click **Run** to execute the background job and inspect breakpoints, parental attributions, diagnostics, timings, and annotations.
4. Export results as `.rdp`, CSV, JSON, TSV, FASTA, standalone HTML, or a complete ZIP archive.

## Tests & Benchmarks

Run the Python workbench test suite (uses bundled checkpoints and `tests/fixtures/`):

```bash
python3 -m unittest discover -s tests -v
```

Benchmark helpers live in `scripts/` (`scripts/benchmark_timings.py`, `scripts/build_and_run_martin_suite.py`).

## Docker (Workbench)

```bash
docker build -t gt-transformer .
docker run --rm -p 8050:8000 gt-transformer
```

Frontend source (`frontend/`) and workflow files (`.github/`) are excluded via `.dockerignore` so the container image only ships the Python workbench.

## Repository Layout

- `frontend/` — Front-facing React + TypeScript + Tailwind + Three.js portal built with Vite (`src/`, `index.html`, `package.json`, `vite.config.ts`)
- `.github/workflows/pages.yml` — Automated build & deploy pipeline publishing `frontend/dist/` to GitHub Pages
- `app.py`, `cli.py`, `schemas.py` — FastAPI server entrypoint, CLI runner, and API schemas
- `routers/` — HTTP endpoints for inference runs, auth, and chat
- `services/` — Inference adapter, SQLite/Postgres persistence, timings, diagnostics, and assistant logic
- `gt_core/` — Core pipeline, Two-Site Window Transformer, Flanking-KL scanner, HalDec consolidator, and training modules
- `checkpoints/` — Bundled `params.pkl` checkpoints (`ckpt_N40000`, `ckpt_N10000`, `ckpt_N10000_extreme`, `ckpt_N10000_v2`)
- `benchmark_data/` — Published scaling & cross-rate summary JSON/CSV files
- `sample_data/` — Example viral alignments (`sarbecovirus_aligned.fasta`, `ULTIMATE_STRESS_TEST_64seq_12000bp.fasta`, etc.)
- `tests/` — Unit/integration tests and validation `fixtures/`
- `static/` and `templates/` — FastAPI workbench frontend assets
- `Dockerfile`, `pyproject.toml`, `requirements.txt`, `run_server.sh` — Packaging and container configuration
