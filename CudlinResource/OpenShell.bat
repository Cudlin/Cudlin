@echo off
:: Check For Administrative Permissions:
>nul 2>nul "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' Goto NoPermission
:: ============================================================================================================================ ::
:: Rename StartMenu:
:RestartStartMenu
taskkill /F /IM StartMenuExperienceHost* >nul 2>&1
Ren "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe" "StartMenuExperienceHost.old" >nul 2>&1
if exist "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe" Goto :RestartStartMenu
:: Rename Search:
:RestartSearch
taskkill /F /IM SearchApp* >nul 2>&1
Ren "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe" "SearchApp.old" >nul 2>&1
if exist "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe" Goto :RestartSearch
:: Disable Search Icon:
Reg.exe Add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f >nul 2>&1
:: Rename RuntimeBroker:
:RestartRuntimeBroker
taskkill /F /IM RuntimeBroker* >nul 2>&1
Ren "%SYSTEMDRIVE%\Windows\System32\RuntimeBroker.exe" "RuntimeBroker.old" >nul 2>&1
if exist "%SYSTEMDRIVE%\Windows\System32\RuntimeBroker.exe" Goto :RestartRuntimeBroker
:: Rename TextInputHost:
:RestartTextInputHost
taskkill /F /IM TextInputHost* >nul 2>&1
Ren "%SYSTEMDRIVE%\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.exe" "TextInputHost.old"
if exist "%SYSTEMDRIVE%\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.exe" Goto :RestartTextInputHost
:: ============================================================================================================================ ::
:: Install OpenShell:
CD /d "%SYSTEMDRIVE%\Cudlin\Resource\" >nul 2>&1
if Not Exist "%SYSTEMDRIVE%\Cudlin\Resource\OpenShellSetup.exe" Curl -L --output "%SYSTEMDRIVE%\Cudlin\Resource\OpenShellSetup.exe" "https://github.com/Cudlin/Cudlin/raw/main/CudlinResource/OpenShellSetup.exe" >nul 2>&1
if Exist "%SYSTEMDRIVE%\Cudlin\Resource\OpenShellSetup.exe" (
"%SYSTEMDRIVE%\Cudlin\Resource\OpenShellSetup.exe" /qn ADDLOCAL=StartMenu
) >nul 2>&1
:: ============================================================================================================================ ::
:: Restart For The explorer Before Start:
Taskkill /F /IM Explorer.exe >nul 2>&1
Start Explorer.exe >nul 2>&1
:: Remove All Skins:
Del "%ProgramFiles%\Open-Shell\Skins\" /S /F /Q >nul 2>&1
:: Setup Skin:
Curl -L --output "%ProgramFiles%\Open-Shell\Skins\FluentMetro.skin7" "https://github.com/Cudlin/Cudlin/raw/main/CudlinResource/FluentMetro.skin7" >nul 2>&1
Curl -L --output "%ProgramFiles%\Open-Shell\Skins\FluentMetro.skin" "https://github.com/Cudlin/Cudlin/raw/main/CudlinResource/FluentMetro.skin" >nul 2>&1
:: Setup XML Settings:
Curl -L --output "%ProgramFiles%\Open-Shell\Skins\cudlin.xml" "https://github.com/Cudlin/Cudlin/raw/main/CudlinResource/cudlin.xml" >nul 2>&1
"C:\Program Files\Open-Shell\StartMenu.exe" -xml "%ProgramFiles%\Open-Shell\Skins\cudlin.xml"
:: Exit The Batch & Taskkill Process:
taskkill /F /IM StartMenu.exe >nul 2>&1
taskkill /F /IM rundll32.exe >nul 2>&1
Exit /b 1

:NoPermission
cls
echo You don't Have Access To Use This Tool. Press any key to continue.
pause >nul & exit /b 1
:: ============================================================================================================================ ::
