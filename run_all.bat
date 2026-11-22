@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0start_ollama.ps1"
start "BeautyGen Backend" /min powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0start_backend.ps1"
start "BeautyGen Frontend" /min powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0start_frontend.ps1"
echo Open http://127.0.0.1:5187 after both servers are ready.
