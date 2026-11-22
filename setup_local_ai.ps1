$ErrorActionPreference='Stop'
$ProjectDir=$PSScriptRoot
$PythonExe=Join-Path $ProjectDir '.venv\Scripts\python.exe'
if (-not (Test-Path -LiteralPath $PythonExe)) {throw 'Run setup_windows.bat first (Python 3.12, Node.js 20+ required).'}
& $PythonExe -m pip install -r (Join-Path $ProjectDir 'backend\requirements-lock.txt')
if ($LASTEXITCODE) {throw 'Local image dependencies could not be installed.'}
$ModelDir=Join-Path $ProjectDir 'backend\data\models'
New-Item -ItemType Directory -Force -Path $ModelDir | Out-Null
$FaceModel=Join-Path $ModelDir 'face_landmarker.task'
if (-not (Test-Path -LiteralPath $FaceModel)) {
    Invoke-WebRequest 'https://storage.googleapis.com/mediapipe-models/face_landmarker/face_landmarker/float16/latest/face_landmarker.task' -OutFile $FaceModel -UseBasicParsing
}
. (Join-Path $ProjectDir 'start_ollama.ps1')
& $OllamaExe pull qwen3-vl:2b-instruct
if ($LASTEXITCODE) {throw 'Model download failed. Check connectivity/disk space, then retry. Existing features work without AI photo interpretation.'}
Push-Location (Join-Path $ProjectDir 'backend')
try {& $PythonExe -c "from app.services import local_vision,landmarks; s=local_vision.status(); print(s); print(landmarks.status()); raise SystemExit(0 if s['ready'] else 1)";if ($LASTEXITCODE) {throw 'Ollama model validation failed. Check backend/.env model name.'}} finally {Pop-Location}
Write-Host 'Local AI setup complete. Run run_all.bat. No billing or API key is needed.'
