@echo off
:: Check for administrative permissions
>nul 2>nul "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' Goto NoPermission
:: ============================================================================================================================ ::
:: Rename StartMenu:
:RestartStartMenu
taskkill /F /IM StartMenuExperienceHost*
Ren "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe" "StartMenuExperienceHost.old"
if exist "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe" Goto :RestartStartMenu
:: Rename Search:
:RestartSearch
taskkill /F /IM SearchApp*
Ren "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe" "SearchApp.old"
if exist "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe" Goto :RestartSearch
:: Disable Search Icon:
Reg.exe Add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f
:: Rename RuntimeBroker:
:RestartRuntimeBroker
taskkill /F /IM RuntimeBroker*
Ren "%SYSTEMDRIVE%\Windows\System32\RuntimeBroker.exe" "RuntimeBroker.old"
if exist "%SYSTEMDRIVE%\Windows\System32\RuntimeBroker.exe" Goto :RestartRuntimeBroker
:: Rename TextInputHost:
:RestartTextInputHost
taskkill /F /IM TextInputHost*
Ren "%SYSTEMDRIVE%\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.exe" "TextInputHost.old"
if exist "%SYSTEMDRIVE%\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.exe" Goto :RestartTextInputHost
:: ============================================================================================================================ ::
:: Install OpenShell:
CD /d "%SYSTEMDRIVE%\Cudlin\Resource\"
if not Exist "%SYSTEMDRIVE%\Cudlin\Resource\OpenShellSetup.exe" Curl -L --output "%SYSTEMDRIVE%\Cudlin\Resource\OpenShellSetup.exe" "https://github.com/Cudlin/Cudlin/raw/main/CudlinResource/OpenShellSetup.exe" >nul 2>&1
if Exist "%SYSTEMDRIVE%\Cudlin\Resource\OpenShellSetup.exe" (
"%SYSTEMDRIVE%\Cudlin\Resource\OpenShellSetup.exe" /qn ADDLOCAL=StartMenu
)
:: ============================================================================================================================ ::
:: Restart For The explorer Before Start:
Taskkill /F /IM Explorer.exe
Start Explorer.exe
:: Remove All Skins:
Del "%ProgramFiles%\Open-Shell\Skins\" /S /F /Q >nul 2>&1
:: Setup Skin:
Curl -g -k -L -o "%ProgramFiles%\Open-Shell\Skins\FluentMetro.skin" "https://github.com/Cudlin/Cudlin/raw/main/CudlinResource/FluentMetro.skin" >nul 2>&1
Curl -g -k -L -o "%ProgramFiles%\Open-Shell\Skins\FluentMetro.skin7" "https://github.com/Cudlin/Cudlin/raw/main/CudlinResource/FluentMetro.skin7" >nul 2>&1
:: Setup XML:
Curl -L --output "%ProgramFiles%\Open-Shell\Skins\cudlin.xml" "https://github.com/Cudlin/Cudlin/raw/main/CudlinResource/cudlin.xml" >nul 2>&1
CD /d "%SystemDrive%\Program Files\Open-Shell\Skins\"
"%ProgramFiles%\Open-Shell\StartMenu.exe" -xml "%ProgramFiles%\Open-Shell\Skins\cudlin.xml"
:: Exit The Batch:
taskkill /F /IM StartMenu.exe
taskkill /F /IM rundll32.exe
Exit /b 1

:NoPermission
cls
echo You don't Have Access To Use This Tool. Press any key to continue.
pause >nul & exit /b 1
:: ============================================================================================================================ ::
