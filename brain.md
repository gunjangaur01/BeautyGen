# BeautyGen — Project Brain

> **Read this file first.** It is the navigation and coordination hub. Details live in `docs/brain/`.

## 1. Project Identity
- **Name:** BeautyGen
- **Academic title:** BeautyGen: A Context-Aware, Reinforcement Learning-Based Beauty Recommendation System for Travel and Changing Weather Conditions
- **Tagline:** *Your Beauty, Adapted to Every Destination.*
- **Owner:** Final-year B.Tech CSE (AI/ML) student project

## 2. Primary Problem Statement
Skincare needs change with environment (temperature, humidity, UV) and activities. Most recommenders ignore travel context and never adapt from feedback. BeautyGen asks: *can a contextual bandit (LinUCB) adapt personalized skincare product rankings to a user's profile and changing travel/weather context, using explicit feedback, while never violating hard ingredient exclusions?*

## 3. Main Research Contribution
Travel- and weather-aware skincare recommendation using **LinUCB**, compared fairly against Fixed, Rule-based, Epsilon-Greedy and Thompson Sampling baselines in a reproducible simulator. Skin/color analysis, styling chatbot, virtual makeup and shopping tools are **supporting platform features, not the contribution**.

## 4. High-Level Architecture
Modular FastAPI monolith + SQLite + React frontend (later).

```
Profile + Trip -> Weather context (Open-Meteo / manual)
 -> Product catalogue -> HARD ELIGIBILITY FILTER (ingredients, budget)
 -> Ranker (rule-based fallback | LinUCB) -> Explanations + Routine
 -> Explicit feedback -> LinUCB update
```
Safety rule: **eligibility runs before ranking; no learned score can override an exclusion; missing ingredient data is never proof of safety.** See [architecture](docs/brain/04-system-architecture.md).

## 5. Current Implementation Status (BeautyGen V7 Complete Skincare & Makeup)
The complete multi-tier India-focused dataset and recommendation platform is fully operational with Skincare and Makeup:
- **10,231 Total Products** across 4 strictly separated catalogue tiers:
  - **Skincare (5,347 products)**: 44 Verified India, 160 Pending Candidates, 5,113 Historical Records, 30 Demo Products.
  - **Makeup (4,884 products)**: 420 Verified India, 4,294 Pending Candidates, 170 Historical Records.
- **5,276 Relational Product Variants & Shades**:
  - Detailed shade names, hex codes, color families (Red, Pink, Nude, Berry, Coral, Plum, Brown, Black, Gold), undertones (Warm, Cool, Neutral), and variant prices.
- **1,905 Total Verified Live Retailer Listings**:
  - 1,079 Skincare retailer listings (Nykaa, Amazon India, Purplle, Tira, Flipkart).
  - 826 Makeup retailer listings (Amazon India, Sephora Nnnow) with verified URLs and observed INR prices.
- **12,298 Budget Alternative Pairs** with calculated rupee savings, percentage discounts, and one-click replacement.
- **216 Automated Backend Tests Passing (100% pass rate)**.
- **AI Integrations Active**:
  - Personal Color Analysis connected to verified makeup recommendations.
  - AI Stylist connected to verified makeup pairings (Lip, Eye, Face).
  - Travel Makeup Essentials climate-adapted kit.
- **Clean redistributable demonstration database** (personal test profiles purged, standard demonstration profiles preserved).
- **Strict safety guardrails**: Missing/partial ingredient evidence is never assumed safe under exclusions (Decision D-003).

| Component | Status |
|---|---|
| Clean FastAPI backend in `backend/` (health, products CRUD, profiles, hard eligibility, SQLite, makeup) | TESTED (216 tests pass; boot + persistence verified) |
| React frontend in `frontend/` (Home, Skin Quiz, Shop, Product, Journal, About, Travel Planner, Color, Stylist) | BUILT, production build passing (`tsc --noEmit && vite build`), Skincare & Makeup tabs, shade swatches |
| Weather & LinUCB adaptive recommendation engine (Open-Meteo, LinUCB with persistent feedback learning) | TESTED & VERIFIED (strict India-market verification, 100% verified live retailer links on cards) |

## 6. Confirmed Technology Choices
**Currently used:** Python, FastAPI, Uvicorn, Swagger UI, VS Code.
**Planned:** Pydantic, SQLAlchemy, SQLite, Pandas, NumPy, Pytest, Git/GitHub, Open-Meteo, React+TypeScript, OpenCV, MediaPipe, Matplotlib, multimodal LLM (provider-neutral). Rationale: [05-tech-stack.md](docs/brain/05-tech-stack.md).

## 7. Planned Modules
A Travel & Weather Intelligence (**central**) · B Skin & Color Intelligence · C Contextual Recommendation Engine · D Styling Chatbot · E Virtual Beauty & Routine Studio · F Personal Beauty Management.

## 8. Current Development Phase
**Core research pipeline built (weather -> eligibility -> rule-based/LinUCB -> feedback -> experiments). Next: validate live weather, real dataset import (Phase 2), secondary modules.** See [roadmap](docs/brain/16-implementation-roadmap.md).

## 9. Next 10 Tasks
1. **BG-009** Inspect Sephora dataset (BG-001–008 done; see dev log)
<!-- old list below kept for history -->
1. **BG-001** Audit repo (use checklist in [01-current-status.md](docs/brain/01-current-status.md))
2. **BG-002** Choose one backend entry point; archive the other prototype
3. **BG-003** Create clean venv + `requirements.txt`; verify server boots
4. **BG-004** Git baseline commit + `.gitignore`
5. **BG-005** Run existing `tests/test_eligibility.py`; record result
6. **BG-006** Modular structure + config + health check
7. **BG-007** SQLAlchemy models (Product, UserProfile) on SQLite
8. **BG-008** Product CRUD + user profile CRUD with tests
9. **BG-009** Inspect Sephora CSV; write `data_inspection.md`
10. **BG-010** Import ~200 cleaned products with provenance flags

Full backlog: [17-task-backlog.md](docs/brain/17-task-backlog.md).

## 10. Important Constraints
- Ingredient exclusion is separate from, and before, learned ranking.
- No medical/diagnostic/allergy-safety claims.
- Photos optional, consented, minimally stored, deletable.
- No invented results; graphs only from computed outputs.
- MVP first; do not start chatbot/makeup before the recommendation engine works.
- Do not treat US Sephora prices as current Indian prices.
- Check licenses before reusing any external code or data.

## 11. Documentation Index
| File | Topic |
|---|---|
| [00-project-overview](docs/brain/00-project-overview.md) | Vision, scope levels, critical path |
| [01-current-status](docs/brain/01-current-status.md) | Status table, audit checklist |
| [02-research-and-resources](docs/brain/02-research-and-resources.md) | Sources and references |
| [03-complete-feature-scope](docs/brain/03-complete-feature-scope.md) | All features by module |
| [04-system-architecture](docs/brain/04-system-architecture.md) | Services, Mermaid diagrams |
| [05-tech-stack](docs/brain/05-tech-stack.md) | Current vs planned stack |
| [06-database-and-datasets](docs/brain/06-database-and-datasets.md) | Schema, data pipeline |
| [07-api-design](docs/brain/07-api-design.md) | Endpoint specs |
| [08-travel-weather-engine](docs/brain/08-travel-weather-engine.md) | Open-Meteo, context, rules |
| [09-linucb-recommendation-engine](docs/brain/09-linucb-recommendation-engine.md) | Math and implementation |
| [10-ai-experiment-lab](docs/brain/10-ai-experiment-lab.md) | Experiment design |
| [11-skin-and-color-analysis](docs/brain/11-skin-and-color-analysis.md) | Photo analysis |
| [12-ai-styling-chatbot](docs/brain/12-ai-styling-chatbot.md) | Chatbot |
| [13-virtual-makeup-and-routines](docs/brain/13-virtual-makeup-and-routines.md) | Makeup, routines |
| [14-beauty-management](docs/brain/14-beauty-management.md) | Shelf, wishlist, etc. |
| [15-privacy-security-and-safety](docs/brain/15-privacy-security-and-safety.md) | Privacy rules |
| [16-implementation-roadmap](docs/brain/16-implementation-roadmap.md) | Phases 0–12 |
| [17-task-backlog](docs/brain/17-task-backlog.md) | Task IDs |
| [18-testing-and-evaluation](docs/brain/18-testing-and-evaluation.md) | Test strategy |
| [19-deployment-and-demonstration](docs/brain/19-deployment-and-demonstration.md) | Deploy and demo |
| [20-decisions-and-open-questions](docs/brain/20-decisions-and-open-questions.md) | Decisions log |
| [21-development-log](docs/brain/21-development-log.md) | Chronological log |

## 12. Instructions for Future AI Assistants
1. Read `brain.md` first.
2. Read the relevant detailed file in `docs/brain/`.
3. Inspect existing source code before changing anything.
4. Never assume a feature is implemented because it is documented.
5. Preserve currently working code.
6. Work on one logical task at a time.
7. Explain each code change in simple language.
8. State which files will be modified before modifying them.
9. Avoid unnecessary packages or complex architecture.
10. Do not implement unrelated features.
11. Follow roadmap dependency order.
12. Run available tests after changes.
13. Clearly report tests that could not be run.
14. Keep ingredient exclusions separate from learned rankings.
15. Keep uploaded images private and optional.
16. Keep technical claims and results evidence-based.
17. Update relevant docs after completing a task.
18. Update the development log.
19. Update task status only after verification.
20. State the next task for the following session.

## 13. Last Updated
- **Date:** 2026-10-26
- **Status notes:** Documentation created without repository access. All implementation status is user-reported. First action: BG-001 audit.


## V4 update (2026-10-27)
Imported 2,194 cleaned Sephora records (historical USD, partial/missing ingredient evidence, no markets) into a separate **Imported catalogue**; demo catalogue stays fictional. Ingredient evidence is never upgraded; strict exclusions require a verified-complete list. Budgets: per-product + total kit, currency-safe; kit assembled by rules from ranked products. UI: full-width, BeautyGen branding, vector artwork (photo drop-in slot), real workflow stepper, stale results. Verified: backend 117 tests, data package 17, frontend build, 22 browser checks, layout at 4 widths. Not verified: live Open-Meteo, real OBF/market data, Python 3.14. Docs: DATA_INTEGRATION.md, TRAVEL_KIT_BUDGET.md, TESTING.md, FINAL_EVALUATION_GUIDE.md.


## V5 update (2026-11-03)
Public Travel Planner simplified (RL internals hidden, Experiment Lab unlinked). View Alternatives + kit swap built and tested. India-market pipeline built; **verified India products = 0** (blocked: no Nykaa/Tira/Purplle/Amazon/Myntra data available) -> labelled Demo mode. Skin Analysis / Color Analysis / Styling Assistant built with consent, in-memory image handling, OpenCV quality checks, local colour measurement, and honest fallbacks; **no real AI-model call was made or verified** (no API key; adapter tested with mocked network). Tests: backend 191 passed, frontend build OK, browser checks 29 (demo) + 10 (synthetic India). Docs: ALTERNATIVES.md, INDIA_CATALOGUE.md, AI_FEATURES.md, PRIVACY.md.
