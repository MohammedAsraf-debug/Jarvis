@echo off
REM MARK LIV — one-click launcher (Windows)
REM Uses the project Python 3.13 virtual environment, never the system Python.
setlocal
cd /d "%~dp0"
set "PYEXE=%CD%\.venv\Scripts\python.exe"

if not exist "%PYEXE%" (
    echo [ERROR] Virtual environment not found:
    echo         "%PYEXE%"
    echo         Run:  py -3.13 -m venv .venv
    echo         Then: "%PYEXE%" setup.py
    pause
    exit /b 1
)

"%PYEXE%" --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] The virtual environment interpreter is broken.
    echo         Delete the .venv folder and recreate it with:
    echo           py -3.13 -m venv .venv
    pause
    exit /b 1
)

echo Starting MARK LIV with %PYEXE% ...
"%PYEXE%" main.py
set "CODE=%ERRORLEVEL%"

if not "%CODE%"=="0" (
    echo.
    echo [ERROR] MARK LIV exited with code %CODE%. See the traceback above.
    pause
    exit /b %CODE%
)
endlocal
