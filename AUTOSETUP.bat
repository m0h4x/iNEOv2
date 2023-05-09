@ECHO OFF

VER | FINDSTR /IL "5.1." > NUL
IF %ERRORLEVEL% EQU 0 goto BEGIN_XP

set admin=N
set domain=%USERDOMAIN%\
If /i "%domain%" EQU "%computername%\" set domain=
set user=%domain%%username%
for /f "Tokens=*" %%a in ('net localgroup administrators^|find /i "%user%"') do set admin=Y


:: checks if UAC is disabled...
FOR /F "tokens=3 delims=	 " %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA') DO SET UserAccount=%%A
ECHO UserAccount=%UserAccount%


IF %UserAccount%==0x0 (GOTO BEGIN_OTHER) ELSE (GOTO RESTART)



:RESTART


set cdrom=none
for %%a in (c d e f g h i j k l m n o p q r s t u v w x y z) do (
fsutil.exe fsinfo drivetype %%a:|find "CD-ROM">nul&&set cdrom=%%a:
)

cls


REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v INEO_resume /f /t REG_SZ /d %cdrom%\AUTOSETUP.bat



@ECHO Turning off anoying UAC Consent prompt now...
PING 1.1.1.1 -n 1 -w 4000 >NUL


REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f



cls
@ECHO Done, Your Pc will restart in 5 seconds, the process will continue after reboot.
PING 1.1.1.1 -n 1 -w 5000 >NUL
shutdown -r -t 5
exit



:BEGIN_OTHER

@ECHO Installation process starts in 60 seconds...
@ECHO OFF
PING 1.1.1.1 -n 1 -w 60000 >NUL

:BEGIN_XP



@ECHO.
@ECHO INEO v1.0      ---  2010
@ECHO.
@ECHO /\-/\-/\-/\-/\-/\-/\-/\-/\-/\-/\-/\-/\-/\-/\
@ECHO.
@ECHO This program will install all your applications one after the other.
@ECHO.
@echo off



@ECHO Process starting...

PING 1.1.1.1 -n 1 -w 2000 >NUL

@ECHO Installation of Winrar...

if exist "%ProgramFiles(x86)%\WinRAR\WinRAR.exe" goto skip_winrar
if exist "%ProgramFiles%\WinRAR\WinRAR.exe" goto skip_winrar

"wrar392.exe" /S
goto winrar_sucess
:skip_winrar


echo Winrar is already installed ! Skipping...
PING 1.1.1.1 -n 1 -w 2000 >NUL


:winrar_sucess
@ECHO Installation of FireFox...

if exist "%ProgramFiles(x86)%\Mozilla Firefox\firefox.exe" goto skip_FF
if exist "%ProgramFiles%\Mozilla Firefox\firefox.exe" goto skip_FF

"Firefox Setup 3.6.exe" -ms
goto FF_sucess

:skip_FF

echo Firefox is already installed ! Skipping...
PING 1.1.1.1 -n 1 -w 2000 >NUL

:FF_sucess
@ECHO Installation of Flash...

"install_flash_player.exe" /S

@ECHO Installation of Adobe Acrobat Reader...

if exist "%ProgramFiles(x86)%\Adobe\Reader 9.0\Reader\AcroRd32.exe" goto skip_Acrobat
if exist "%ProgramFiles%\Adobe\Reader 9.0\Reader\AcroRd32.exe" goto skip_Acrobat


cd AcrobatReader
msiexec /qn /i AcroRead.msi
cd..
goto acrobat_sucess

:skip_Acrobat


echo Acrobat Reader is already installed ! Skipping...
PING 1.1.1.1 -n 1 -w 2000 >NUL


:acrobat_sucess
@ECHO Installation of VLC Player...

if exist "%ProgramFiles(x86)%\VideoLAN\VLC\vlc.exe" goto skip_vlc
if exist "%ProgramFiles%\VideoLAN\VLC\vlc.exe" goto skip_vlc

"vlc-1.0.5-win32" /S
goto vlc_sucess

:skip_vlc
echo VLC is already installed ! Skipping...
PING 1.1.1.1 -n 1 -w 2000 >NUL


:vlc_sucess
@ECHO Installation of AVG 9...

if exist "%ProgramFiles(x86)%\AVG\AVG9\avgui.exe" goto skip_avg
if exist "%ProgramFiles%\AVG\AVG9\avgui.exe" goto skip_avg


"avg_free_stf_eu_90_790a2730.exe" /HIDE /NO_WELCOME /NOAVGTOOLBAR /NORESTART /QUIT_IF_INSTALLED
goto avg_sucess


:skip_avg
echo AVG9 is already installed ! Skipping...
PING 1.1.1.1 -n 1 -w 2000 >NUL


:avg_sucess
@ECHO Installation of MalwareBytes...

if exist "%ProgramFiles(x86)%\Malwarebytes' Anti-Malware\mbam.exe" goto skip_malw
if exist "%ProgramFiles%\Malwarebytes' Anti-Malware\mbam.exe" goto skip_malw

"malwarebytes.exe" /verysilent
goto malw_sucess


:skip_malw
echo Malwarebytes is already installed ! Skipping...
PING 1.1.1.1 -n 1 -w 2000 >NUL

:malw_sucess
@ECHO Installation of magic disc...

if exist "%ProgramFiles(x86)%\MagicDisc\MagicDisc.exe" goto skip_magic
if exist "%ProgramFiles%\MagicDisc\MagicDisc.exe" goto skip_magic


"setup_magicdisc.exe" /s
goto magic_sucess


:skip_magic
echo MagicDisc is already installed ! Skipping...
PING 1.1.1.1 -n 1 -w 2000 >NUL


:magic_sucess
@ECHO Installation of Open Office 3.2...

if exist "%ProgramFiles(x86)%\OpenOffice.org 3\program\soffice.exe" goto skip_office
if exist "%ProgramFiles%\OpenOffice.org 3\program\soffice.exe" goto skip_office

"OOo_3.2.0_Win32Intel_install_wJRE_en-US" /S
goto office_sucess


:skip_office
echo OpenOffice is already installed ! Skipping...
PING 1.1.1.1 -n 1 -w 2000 >NUL

:office_sucess

VER | FINDSTR /IL "6.0" > NUL
IF %ERRORLEVEL% EQU 0 goto skip_wmp11

VER | FINDSTR /IL "6.1" > NUL
IF %ERRORLEVEL% EQU 0 goto skip_wmp11


@ECHO Installation of Windows Media Player 11 for Windows XP...
"wmp11-windowsxp-x86-FR-FR.exe" /q



:skip_wmp11



@ECHO Installation of itunes...

if exist "%ProgramFiles(x86)%\iTunes\iTunes.exe" goto skip_itunes
if exist "%ProgramFiles%\iTunes\iTunes.exe" goto skip_itunes

"iTunesSetup.exe" /quiet
goto itunes_sucess

:skip_itunes
echo itunes is already installed ! Skipping...
PING 1.1.1.1 -n 1 -w 2000 >NUL

:itunes_sucess
@ECHO Installation of quicktime...


if exist "%ProgramFiles(x86)%\QuickTime\QuickTimePlayer.exe" goto skip_QT
if exist "%ProgramFiles%\QuickTime\QuickTimePlayer.exe" goto skip_QT


"QuickTimeInstaller.exe" /quiet
goto QT_sucess


:skip_QT
echo Quicktime is already installed ! Skipping...
PING 1.1.1.1 -n 1 -w 2000 >NUL

:QT_sucess

VER | FINDSTR /IL "5.1." > NUL
IF %ERRORLEVEL% EQU 0 goto THEEND


@ECHO Removing reboot procedures...

REG DELETE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v INEO_resume /f



THEEND

color 2f
@ECHO.
@ECHO All Done !
@ECHO.
@ECHO It is recommanded to reboot your computer for better results.

@ECHO OFF
@ECHO Thanks for using INEO Sofware, please leave a comment on the INEO website.
@ECHO Your disk will now eject in 5 seconds... 
PING 1.1.1.1 -n 1 -w 5000 >NUL

@ECHO OFF



"Eject.exe"
exit





