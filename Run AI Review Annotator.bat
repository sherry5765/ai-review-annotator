@echo off
rem Double-click to start AI Review Annotator without opening a terminal.
cd /d "%~dp0"
if exist ".venv\Scripts\pythonw.exe" (
    start "" ".venv\Scripts\pythonw.exe" app.py
) else (
    start "" pythonw app.py
)
