: << 'CMDBLOCK'
@echo off
setlocal

:: Try standard Git Bash locations
if exist "C:\Program Files\Git\bin\bash.exe" (
    "C:\Program Files\Git\bin\bash.exe" "%~dp0%~1" %2 %3 %4 %5 %6 %7 %8 %9
    exit /b %errorlevel%
)
if exist "C:\Program Files (x86)\Git\bin\bash.exe" (
    "C:\Program Files (x86)\Git\bin\bash.exe" "%~dp0%~1" %2 %3 %4 %5 %6 %7 %8 %9
    exit /b %errorlevel%
)

:: Fall back to bash on PATH
where bash >nul 2>nul
if %errorlevel% equ 0 (
    bash "%~dp0%~1" %2 %3 %4 %5 %6 %7 %8 %9
    exit /b %errorlevel%
)

:: No bash found — exit silently
exit /b 0
CMDBLOCK

# Unix: run the named script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_NAME="$1"
shift
exec bash "$SCRIPT_DIR/$SCRIPT_NAME" "$@"
