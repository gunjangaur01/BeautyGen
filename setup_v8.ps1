$ErrorActionPreference = 'Stop'
$ProjectDir = $PSScriptRoot
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw 'Install Python 3.12 and enable Add to PATH.' }
if (-not (Get-Command npm.cmd -ErrorAction SilentlyContinue)) { throw 'Install Node.js 20+ with npm.' }
Push-Location $ProjectDir
try {
    if (-not (Test-Path '.venv/Scripts/python.exe')) { python -m venv .venv; if ($LASTEXITCODE) { throw 'venv creation failed' } }
    if (-not (Test-Path 'frontend/.env')) { Copy-Item -LiteralPath 'frontend/.env.example' -Destination 'frontend/.env' }
    if (-not (Test-Path 'backend/.env')) { Copy-Item -LiteralPath 'backend/.env.example' -Destination 'backend/.env' }
    & '.\.venv\Scripts\python.exe' -m pip install -r backend/requirements-lock.txt
    if ($LASTEXITCODE) { throw 'Backend dependency installation failed' }
    if (-not (Test-Path 'backend/beautygen.db')) { Copy-Item -LiteralPath 'backend/data/beautygen_clean.db' -Destination 'backend/beautygen.db' }
    & '.\.venv\Scripts\python.exe' backend/scripts/repair_ingredients.py --db backend/beautygen.db --evidence backend/data/repairs/manufacturer_ingredient_declarations.json
    if ($LASTEXITCODE) { throw 'Manufacturer ingredient overlay validation failed' }
    & '.\.venv\Scripts\python.exe' backend/scripts/import_skincare_expansion.py --db backend/beautygen.db --evidence backend/data/repairs/verified_skincare_expansion.json
    if ($LASTEXITCODE) { throw 'Reviewed skincare import failed' }
    Push-Location backend
    try { & '..\.venv\Scripts\python.exe' scripts/verify_v8_install.py; if ($LASTEXITCODE) { throw 'Database validation failed' } } finally { Pop-Location }
    Push-Location frontend
    try { npm.cmd ci --no-audit --no-fund; if ($LASTEXITCODE) { throw 'Frontend dependency installation failed' }; npm.cmd run build; if ($LASTEXITCODE) { throw 'Frontend build failed' } } finally { Pop-Location }
    Write-Host 'Next run setup_local_ai.bat for free local photo interpretation. BeautyGen setup passed. Run run_all.bat, then open http://127.0.0.1:5187'
} finally { Pop-Location }
