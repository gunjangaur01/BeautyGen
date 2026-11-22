> Current setup: see [WINDOWS_LOCAL_AI.md](WINDOWS_LOCAL_AI.md). AI now runs locally with Ollama/MediaPipe/OpenCV; legacy cloud setup below is historical. No paid API key is needed.

# BeautyGen — Ingredient and Recommendation Repair

Start with reports/INGREDIENT_RECOMMENDATION_REPAIR.md for the current result, tests, evidence and remaining limits. The full existing V8 project is included, with repaired ingredient imports, dynamic filters/alternatives, updated Analysis UI and Google Gemini integration.

## Run

Extract the project; run setup_windows.bat, then run_all.bat. Defaults: frontend http://127.0.0.1:5173 and backend http://127.0.0.1:8000. Stop other copies before using the default launchers. The current development session instead uses backend 8009 because 8000 was already occupied; its frontend environment is configured accordingly.

## Enable Google Gemini photos

Run setup_gemini.bat in the extracted project. Enter your Gemini key privately in the local terminal, select a vision-capable model available to your Google project, and restart the BeautyGen backend. Reload Analysis. Photos are sent only after consent; no key is included in this ZIP. Without configuration, quality checks and manual preferences work, and the app does not invent photo-analysis results.

221 automated tests and the production frontend build pass. The clean distributed database has no personal profiles, histories or learned state. Create your own profile before planning a trip. Not every product has a complete manufacturer ingredient declaration; exclusions remain strict for those records.
