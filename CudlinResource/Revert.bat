@Echo OFF
:: Rename StartMenu:
:RestartStartMenu
Ren "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.old" "StartMenuExperienceHost.exe"
IF Exist "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.old" Goto RestartStartMenu
:: Rename Search:
:RestartSearch
Ren "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.old" "SearchApp.exe"
IF Exist "%SYSTEMDRIVE%\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.old" Goto RestartSearch
:: Turn On The Search Taskbar Mode:
Reg.exe Add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "1" /f
:: Rename RuntimeBroker:
:RestartRuntimeBroker
Ren "%SYSTEMDRIVE%\Windows\System32\RuntimeBroker.old" "RuntimeBroker.exe"
IF Exist "%SYSTEMDRIVE%\Windows\System32\RuntimeBroker.old" Goto RestartRuntimeBroker
:: Rename TextInputHost:
:RestartTextInputHost
Ren "%SYSTEMDRIVE%\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.old" "TextInputHost.exe"
IF Exist "%SYSTEMDRIVE%\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.old" Goto RestartTextInputHost
:: Taskkill StartMenu:
Taskkill /F /IM StartMenu.exe
:: Restart The Explorer & Delete The All Locations:
Taskkill /F /IM Explorer.exe 
Start Explorer.exe
Rd "%ProgramFiles%\Open-Shell\Skins"
Del /S /Q "%ProgramFiles%\Open-Shell\*"
Rmdir /S /Q "%ProgramFiles%\Open-Shell"
Del /S /Q "%ProgramFiles%\Open-Shell\"
Taskkill /F /IM StartMenu.exe
Taskkill /F /IM Explorer.exe
Start Explorer.exe
powershell -Command "Remove-Item -Path 'C:\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\Open-Shell\\*' -Recurse -Force; Remove-Item -Path 'C:\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\Open-Shell' -Recurse -Force"
:: Remove all related registry entries:
Reg.exe Delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage" /v "Open-Shell Start Menu" /f
Reg.exe Delete "HKCU\Software\OpenShell" /f
Reg.exe Delete "HKLM\SOFTWARE\OpenShell" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\83A41A42B15BE6F49822598F867F9843" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\9F53BA92116D43B4CB3E15C7018C93FA" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\A529FB910C58CFE4F8C090B1EF3555AF" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\A71ACEFF500C48D4F9C7BD8CAEE2B1A5" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\ACBB761224DF5824EA00C9DDFD34B603" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\B56117C51545B714DA5F6889E32D84A9" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\BBADDA7E910E39840B8C023076EEBECA" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\CB0AC1034DD152A4E8E1AFA110438A41" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\CD4EC44177C039747BA93AE2849AE046" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\DA4C63ECBC3F0EA4CAA048F5C5B7E35D" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\DE518B6ADB1916F4383B9F081420B69B" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\E15396FBF36713A41808A793AA54149B" /f
Reg.exe Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Open-Shell Start Menu" /f
Exit /b 1