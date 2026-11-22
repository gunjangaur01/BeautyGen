# BeautyGen — free local AI on Windows

BeautyGen now uses Ollama, MediaPipe and OpenCV. No Google/Gemini/Anthropic API key, account billing or paid image-generation service is required. The premium white/lilac UI and existing HTTP routes are retained.

## What each feature actually needs

| Feature | Implementation | Needs image generation? |
|---|---|---|
| 1–8 skin photos | OpenCV quality/duplicate checks, MediaPipe landmarks/face crops, strict-schema local Qwen3-VL interpretation in a single labelled overview; return tentative observations | No: image understanding |
| Personal colour | MediaPipe cheek/forehead samples, OpenCV CIELAB measurement, explicitly heuristic undertone/depth and palette | No: measurement and rules |
| Outfit & accessories | Local vision model reads an optional outfit photo; typed-only mode retains the labelled rule-based stylist | No: image understanding/text suggestions |
| Lipstick, lip liner, blush, highlighter, base, eyeliner | Landmark masks, texture-preserving colour overlays, five lighting transforms | No: deterministic editing |
| Novel photos, new poses/backgrounds, realistic generative relighting | Not required by these workflows; not fabricated | Would require a separate generative model |
| Skincare + makeup recommendations | Existing catalogue, ingredient restrictions, budget, weather and evidence-aware ranking | No AI generation |

Try-on is an approximate overlay, not a physical shade/finish test. Mascara, complex eye shadow and unsupported effects return a clear explanation. Products without a documented colour require an uploaded swatch or explicit confirmation of an approximate colour.

## Fresh Windows setup

1. Install **Python 3.12 (64-bit)** with Add to PATH, and **Node.js 20+**.
2. Install [Ollama for Windows](https://ollama.com/download/windows). Reopen your terminal after installation. Ollama can run without signing in; use downloaded local models only.
3. Extract the source ZIP to a writable folder. Run `setup_windows.bat` to install pinned Python dependencies, initialise a clean database, validate catalogue repairs and build the frontend.
4. Run `setup_local_ai.bat`. This checks MediaPipe/OpenCV, obtains the face-landmarker asset if absent, starts local Ollama if necessary, and downloads **qwen3-vl:2b-instruct** (roughly 1.9 GB). Initial setup requires internet and several GB of disk space. Inference uses your computer, with no API calls or billing.
5. Run `run_all.bat`; open **http://127.0.0.1:5187/**. Backend: **http://127.0.0.1:8018/docs**.

PowerShell equivalents (run from the extracted project folder):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\setup_v8.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\setup_local_ai.ps1
.\run_all.bat
```

The old `setup_gemini.bat` entry point redirects to local setup and does not accept/store a key. Existing local profile data is retained. A fresh package starts from the clean catalogue DB without personal profiles or photos. The source package includes MediaPipe/OpenCV face assets, but excludes Python/Node installations and Ollama weights/runtime.

## Model and hardware

Use the explicit **instruct** variant. The generic `qwen3-vl:2b` tag tested here produced lengthy reasoning and timed out; it is not the configured default.

`backend/.env` (copy `.env.example` if missing):

```dotenv
BEAUTYGEN_VISION_PROVIDER=ollama
BEAUTYGEN_OLLAMA_MODEL=qwen3-vl:2b-instruct
BEAUTYGEN_OLLAMA_URL=http://127.0.0.1:11434
BEAUTYGEN_OLLAMA_TIMEOUT_S=240
BEAUTYGEN_OLLAMA_CONTEXT=4096
```

A 16 GB RAM PC is a practical starting point; The eight-upload timing check completed in 115 seconds on this CPU. Busy or slower computers can take longer; this is not a hard deadline. Close unused memory-heavy applications if Ollama cannot allocate the model. Fast overview mode: all usable face crops are composed into one labelled overview and interpreted in one model pass to bound image/context memory. A larger local vision model may improve detail but needs more RAM; install it with `ollama pull MODEL` and change the model setting. Accuracy is uncalibrated and depends on lighting and the chosen model. Skin results remain tentative cosmetic observations, not diagnosis or measured hydration/sensitivity.

The project launcher uses `OLLAMA_NO_CLOUD=1`, loopback binding and one loaded model. It reuses an existing local Ollama server, or starts one. In this prepared workspace it also detects the downloaded portable runtime at `../../ollama-runtime` and weights at `../../ollama-models`; extracted copies normally use the installed Ollama CLI and its standard model storage.

## Demo flow

Dashboard → Start skin journey → complete quiz → add 7–8 clear photos → consent → Check photo quality → Analyse my photos → review observations → explicitly confirm/correct skin preferences → Travel Planner → choose destination result and dates → Plan My Trip → separate Skincare / Makeup tabs → open a supported makeup shade → Try on your photo → upload a clear portrait and shade reference → consent → Create 5 lighting previews → AI Stylist.

Colour analysis and manual preferences remain usable without Ollama. Typed-only stylist responses explicitly identify rule-based mode. A failed/unavailable AI model never produces invented photo observations or previews.

## Troubleshooting

- **Ollama unavailable:** start the Ollama desktop app, or run `ollama serve`. Check `http://127.0.0.1:8018/ai/status` for the exact local readiness message.
- **Model missing:** `ollama pull qwen3-vl:2b-instruct`. `ollama list` must show the exact configured tag. Text-only and cloud-forwarding models are rejected.
- **Timeout / not enough RAM:** close unused apps, retry one photo to check inference, then eight photos. Increase `BEAUTYGEN_OLLAMA_TIMEOUT_S` if appropriate. A truncated/invalid JSON response is an error, never a successful skin result.
- **Face assets missing/broken:** rerun `setup_local_ai.bat`; verify `backend/data/models/face_landmarker.task`. `/tryon/status` reports landmark availability. OpenCV Haar files are bundled because the tested OpenCV 5 wheel omits them.
- **No face / several faces / blur:** upload a sharp, evenly lit, single-person portrait. Profile shots are quality warnings; try-on needs a front-facing portrait.
- **No product recommendations:** inspect budget, ingredient exclusions and evidence coverage. Filters are not relaxed to fill cards. Ingredient-sensitive profiles can legitimately have fewer eligible brands despite a large catalogue.
- **Port conflict:** close a previous BeautyGen server before relaunching. Both frontend `.env` and backend CORS must use the documented ports.

## Privacy and preserved API contracts

Photos pass only to local OpenCV/MediaPipe and the loopback Ollama server. Skin/colour/outfit inputs are processed in memory. Try-on jobs/previews are in memory for at most 30 minutes, protected by their private token, and can be discarded sooner. Saved preferences/palette/notes use existing explicit-save flows; photos are not saved in the app database. Weather/destination lookup and retailer links keep their existing internet functionality.

Preserved routes include `/ai/status`, `/skin/check`, `/skin/analyze`, `/color/analyze`, `/color/palette`, `/styling/chat`, `/profiles/{id}/apply-skin-preferences`, `/saved`, `/tryon/status`, `/tryon/jobs` and job read/delete routes. Status responses include additional local-readiness metadata. Existing recommendation, travel, profile and catalogue endpoints remain available.

## Verification and attribution

Backend tests: from `backend`, run `..\.venv\Scripts\python.exe -m pytest -q`. Frontend: `npm.cmd --prefix frontend run build` from the project root. Unit tests mock model inference; live inference checks are recorded separately in the delivered validation report.

Official dependencies/resources: [Ollama API](https://docs.ollama.com/api/chat), [Qwen3-VL instruct model](https://ollama.com/library/qwen3-vl:2b-instruct), [MediaPipe Face Landmarker](https://developers.google.com/edge/mediapipe/solutions/vision/face_landmarker/python), [OpenCV Haar assets](https://github.com/opencv/opencv/tree/4.x/data/haarcascades). Respect their upstream licences; face-model and Haar asset origin/hash information is recorded in `backend/data/models/ASSETS.json`.

## Latest recommendation and photo review refinements

Makeup now covers six category groups, optimises the kit for category coverage within the remaining combined budget, and offers separately labelled alternative matches. All alternatives retain per-product price and ingredient restrictions. Fifteen additional exact manufacturer ingredient declarations and further category corrections are included. For the tested fragrance-excluding profile, 25 products across four brands were eligible; the selected four-item makeup kit was INR 2004, with skincare + makeup INR 3979 under a INR 4000 limit. Eligibility depends on your exclusions, budget and evidence freshness.

Photo review now shows visible findings first, omits unresolved metric cards, labels quiz skin type separately when photos cannot establish it, deduplicates findings and removes unsupported concern suggestions. A timed loading overlay stays visible during analysis. The marked provider paragraph, Discard photos button, brand-coverage panel and optional swatch upload have been removed. Per-photo remove and preview-clearing controls remain available. Products without recorded swatches still require confirmation of a manually selected approximate colour.


## Skincare catalogue update (17 November 2026)

Added 23 reviewed product families from Minimalist, Plum, Simple and Deconstruct with full manufacturer ingredient declarations, recorded INR prices and available exact variants. The setup importer is idempotent and leaves makeup and user profiles unchanged. Skin, weather, ingredient exclusions and budgets still determine eligibility/ranking; variety does not override hard restrictions. Category buttons expose all eligible skincare matches.

Profile 1 equivalent (oily, fragrance excluded, INR 1000 per product / 3000 kit) was checked against the live Gurugram forecast: 41 eligible products across six brands, first four matches from four brands, and a three-brand INR 1253 kit. This is an integration check, not a measured prediction-accuracy percentage or clinical validation.

Cheaper alternatives distinguish upfront pack price from per-unit value when quantities and units are documented. Product-page comparisons use the travel profile when available; direct catalogue comparisons explicitly state when no profile was checked.

All recorded current retailer offers are displayed without the former three-link cap. Two additional exact-pack Purplle listings were verified for the Plum 25g moisturizer and Deconstruct 30g sunscreen. Other platforms appear as clearly labelled searches, not invented availability. Sold-out, unverified and different-pack results are not presented as confirmed stock.

For sustained wider coverage, regularly ingest/review retailer or affiliate product feeds keyed to exact variant and pack size, including current price, stock, full INCI and texture. Historical catalogue size alone cannot establish ingredient suitability or live availability. Current evidence expires after 30 days; refresh reviewed source observations before then. The bundled importer reapplies recorded observations; it is not a live all-store crawler.

The analysis timer is replaced by a circular loader. Footer, bag controls and dataset menu entry are removed; Personal colour analysis sits beside AI Stylist. Makeup recommendation logic remains unchanged. Launch scripts use backend port 8018 and frontend port 5187.


## Store comparison update
The duplicate travel alternatives sidebar is removed. Product-specific alternatives remain inside the cards and on product pages. All skincare and makeup cards, product pages and alternative cards now share a six-store section: Official website, Amazon, Flipkart, Nykaa, Tira and Purplle. Observed retailer listings show recorded prices; when a platform has no verified offer, its button is explicitly a product search. Unknown official links are never guessed. Store searches do not establish availability or current prices. Recommendation and makeup selection logic are unchanged.


## Latest recommendation and retailer policy
The needs/weather refinement supersedes the earlier store-search and ranking notes above. See docs/NEEDS_WEATHER_REFINEMENT.md: budget is an eligibility limit, the UI shows a relevant shortlist, and only verified priced direct product offers are displayed. Unverified store searches are removed.
