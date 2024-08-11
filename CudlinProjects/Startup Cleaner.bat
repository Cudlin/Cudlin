@echo off & cls

:: TEMP V1
if exist "%WINDIR%\Temp\*" (
    for /d %%i in ("%WINDIR%\Temp\*") do Rd /s /q "%%i"
    del /q /f "%WINDIR%\Temp\*" 
) >nul 2>&1

:: TEMP V2
if exist "%TEMP%\*" (
    for /d %%i in ("%TEMP%\*") do Rd /s /q "%%i" >nul 2>&1
    del /q /f "%TEMP%\*" >nul 2>&1 
) >nul 2>&1
EXIT /B 0
