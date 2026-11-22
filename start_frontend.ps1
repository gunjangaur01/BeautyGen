$ErrorActionPreference='Stop'
Set-Location "$PSScriptRoot/frontend"
if (-not (Test-Path 'node_modules')) { throw 'Run setup_windows.bat first.' }
npm.cmd run dev -- --host 127.0.0.1 --port 5187 --strictPort

