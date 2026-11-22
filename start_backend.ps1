$ErrorActionPreference='Stop'
Set-Location "$PSScriptRoot/backend"
$PythonExe=Join-Path $PSScriptRoot '.venv/Scripts/python.exe'
if (-not (Test-Path $PythonExe)) { throw 'Run setup_windows.bat first.' }
& $PythonExe -m uvicorn app.main:app --host 127.0.0.1 --port 8018

