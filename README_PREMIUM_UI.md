# BeautyGen — Premium UI Redesign

This is the complete existing V8 application with a reference-led React frontend redesign. The interface inside the four laptop mockups was recreated as components; the laptop, keyboard, external background and reference screenshots are not embedded in the application.

## What changed
- Shared BeautyGen leaf wordmark, beauty-companion tagline, horizontal icon navigation and active rose tabs. Existing routes remain; Routine Builder and Profile have direct aliases. Research code remains hidden from ordinary navigation.
- Full-width blush/cream/peach canvas, burgundy serif headings, dusty-rose buttons, delicate borders, rounded translucent panels and soft shadows; consistent styling on Shop, Quiz, Color, details and other existing pages.
- Dashboard: four summary cards; skin/travel/stylist grid; real catalogue discovery; actual session routine checklist and self-reported concern count.
- Skin Analysis: primary photo preview plus eight independent upload slots, actual quality/consent actions, eight metric tiles, real summary/empty states, manual preference confirmation, concern panel, AM/PM structure and real catalogue products.
- Travel Planner: compact destination/date/budget/profile toolbar, live weather overview, AM/PM routine columns, interactive packing list, climate notes, real recommendations, connected alternatives and updated totals. Existing APIs and LinUCB logic are reused.
- Stylist: five summary cards, outfit/photo inputs, occasion tiles, trip context, five recommendation columns, editorial moodboard, original accessory sketches, explanation, makeup intensity preference and working saved looks. The existing conversation remains one connected chat. Typed preferences and actual backend replies drive suggestions.
- Regression repair: the V8 product detail retailer filter referenced selectedVariant before its state declaration. It now runs after initialization; multiple-shade buying-link changes were tested in the browser.

## Preserved
All backend and dataset files match the input V8 ZIP byte-for-byte. SQLite databases, CSVs, lineage, ETLs, original tests, real weather adapter, recommendation/eligibility logic and LinUCB code were not rebuilt or edited. No new dependencies were added. The shipped database contains no personal profiles, history, saved results or learned state.

## Validation
- Frontend: TypeScript and Vite production build passed. See reports/premium_frontend_build.txt.
- Backend: all 217 existing tests passed, with one dependency deprecation warning. See reports/premium_backend_regression.txt.
- Browser: four main layouts reviewed at 1440px and refined; eight phone/tablet checks at 390px and 768px found no horizontal overflow in main content. Existing route headings, manual skin entry, makeup search, product details, shade links, wishlist action, stylist response/save, destination search, real forecast, recommendation, kit swap and checklist were exercised.
- Actual QA trip: New Delhi, 15–19 November 2026; INR 1000 per-product and INR 2500 kit limits. The initial kit cost INR 2495; selecting a recorded lower pack-price option updated routine/packing/kit to INR 1696. Pack quantities differed, so this is not a unit-price saving claim.
- Four actual full-page desktop screenshots are in screenshots/. They show a disposable QA profile and actual backend responses. That QA database is outside the ZIP. A clean installation will initially show empty personalized results until a profile/trip is created.
- Preservation and detailed checks: reports/PREMIUM_UI_VALIDATION.json, premium_preservation_check.json, premium_responsive_checks.json and premium_route_checks.json.

## Visual and service limits
This is a close recreation of the references' layout and design language, not a pixel-perfect claim. Available licensed photographs differ from the reference model/location imagery. Real input controls, long real product names, truthful empty states and the connected chat require more vertical space than the static mockups. The generic Santorini scene is explicitly labelled travel inspiration; it is not presented as a photograph of the selected destination. Moodboard/accessory illustrations are editorial inspiration, not generated personalized inference.

The backend does not provide validated hydration/oil/acne/pore/pigmentation/glow percentages or a face-shape classifier. Those values remain unmeasured; they were not copied from the references. Vision requires a configured provider key and real model; no paid vision call was made. Color palettes remain the existing local/manual features. Branded product photo permissions remain unestablished, so the app shows labelled owned illustrations. No ratings, prices, weather or user scores were invented. The underlying V8 data/service limitations in reports/DELIVERY_STATUS.md still apply.

Routine progress and the active trip are held in frontend session memory; they clear on a page refresh. Explicitly saved styling results use the existing protected saved-results API. Wishlist/bag retain their existing local browser behavior and have no checkout.

## Editorial image credits
Bundled photographs are used as decorative editorial content, never as uploaded user photos, branded packshots or endorsements. Source URLs and the Unsplash License are recorded in frontend/public/editorial/LICENSES.json. Santorini: Florian Wehde, https://unsplash.com/photos/white-and-blue-dome-building-OJScR4tDRyc . Portrait: identified by original Unsplash media URL in LICENSES.json. License: https://unsplash.com/license . Blossoms and accessory drawings are owned SVG components.

## Windows run instructions
1. Extract the complete BeautyGen-V8-Premium-UI folder.
2. Install Python 3.12 and Node.js 20+ if missing.
3. With prior dev servers stopped, run setup_windows.bat. It creates a venv, installs pinned backend and locked frontend dependencies, validates the integrated database and builds the frontend.
4. Run run_all.bat. Open http://127.0.0.1:5173; backend docs: http://127.0.0.1:8000/docs.
5. Create your profile in Skin Quiz, then use Travel Planner. Optional AI configuration is described by backend/.env.example. No key is included. Keep servers on localhost.

QA used ports 5178/8008 to avoid an already running application. These QA URLs are not the installation defaults. The production bundle uses the existing default backend URL on port 8000.
