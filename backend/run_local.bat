@echo off
cd /d "%~dp0"
echo.
echo ========================================
echo Sentimen Ijazah - Backend Local Setup
echo ========================================
echo.

REM Check if venv exists
if not exist "venv" (
    echo [1/3] Creating virtual environment...
    python -m venv venv
    call venv\Scripts\activate.bat
) else (
    echo [1/3] Activating virtual environment...
    call venv\Scripts\activate.bat
)

echo [2/3] Installing dependencies...
pip install -r requirements.txt --quiet

echo.
echo [3/3] Starting server on http://localhost:8000
echo.
echo Press Ctrl+C to stop
echo.

uvicorn main:app --reload --host 0.0.0.0 --port 8000

pause
