# BeautyGen compact UI

Read reports/ANALYSIS_TRAVEL_FIXES.md for the latest Analysis/Travel repairs and reports/COMPACT_UI_REVIEW.md for the compact homepage. The homepage follows the latest reference's compact hero/features/products structure. See screenshots/05-home-compact.jpg. Earlier screenshots document the previous design.

## Run on Windows

Extract the complete project, run setup_windows.bat, then run_all.bat. Defaults are frontend http://127.0.0.1:5173 and backend http://127.0.0.1:8000. Do not start a second copy on occupied ports. The current live session uses backend 8009 because another application already occupies 8000. Optional real vision setup is documented in backend/.env.example; no credentials are included.

All existing backend/data source, databases, CSVs, ETLs and tests are included from the clean input project. No personal state from the running application is shipped. Product photography remains permission-gated. Bag and wishlist actions are local browser features without checkout.
