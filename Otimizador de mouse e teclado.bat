��
@echo off
Reg.exe ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f 
color 5
title Teclado e Mouse Tweaks by zJu4nn
mode 145,30
reg add HKLM /F 
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

setlocal EnableDelayedExpansion


REM Blank/Color Character
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

REM Add ANSI escape sequences
reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f 



:startmenu
cls
echo.
echo.
echo.
echo.                                                             START MENU!
echo.                  "============================================================================================="        
echo.                                 Lembre de fazer um ponto de restauracao, se quiser reverter as alteracoes!                                                                                          
echo.                                                                                                                     
echo.                                                                                                                    
echo.                                              [1] Fazer ponto de restauracao    [2] Continue
echo.                                                          
echo.                                                              
echo.                  "============================================================================================="


set /p input=: 
if /i %input% == 1 goto restorepoint
if /i %input% == 2 goto menu
if /i %input% == X cls & goto mouse

) ELSE (
echo Invalid Input & goto MisspellRedirect

:MisspellRedirect
cls
echo Misspell Detected
timeout 2 > null
goto RedirectMenu

:RedirectMenu
cls
goto :real



:restorepoint
echo.
echo [-] Criando Ponto de Restauracao
echo.
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 1 /f >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'Teclado e Mouse Tweaks by zJu4nn' >nul 2>&1

echo.
echo.                                                             Pressione ENTER para continuar...
pause >nul                                                                 
cls  
goto startmenu

:MENU

color D
cls                 
echo.                      
echo.                           
echo.                                                        
echo.                                                        "Tweaks de Teclado"
echo.                      "====================================================================================="                                           
echo.                                           Isso diminuira drasticamente o inputlag,
echo.                                  Alem disso, faz com que o teclado e o mouse sejam mais responsivos.
echo.
echo.
echo.                                         [1] Data Queue Size            [2] Mouse Tweaks
echo.
echo.                                                       [3] Teclado Tweaks           
echo.
echo.                                                     
echo.                                                         Translate by @zJu4nn
echo.                                                         Credits to @exmfnbr
echo.
echo.                     "=======================================================================================" 
echo.

set /p input=: 
if /i %input% == 1 goto data
if /i %input% == 2 goto mou
if /i %input% == 3 goto kb
if /i %input% == 4 goto filter

) ELSE (
echo Invalid Input & goto MisspellRedirect

:MisspellRedirect
cls
echo Misspell Detected
timeout 2 > nul
goto Redirectmouse


:Redirectmouse
cls
echo Wait.
timeout 1 > nul
cls
echo Wait..
timeout 1 > nul
cls
echo Wait...
timeout 1 > nul
goto :mouse


:kb
echo
echo  [-] Desativando as teclas de aderencia
echo.

Reg.exe add "HKCU\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "0" /f

echo.
echo [-] Teclado Tweaks
echo.

Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "DelayBeforeAcceptance" /t REG_SZ /d "0" /f

Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last BounceKey Setting" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Delay" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Repeat" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Wait" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f

echo.
echo Todos os ajustes foram aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU 

:mou
echo.
echo [-] Ajustando as configuracoes do mouse do painel de controle
echo.
Reg.exe add "HKU\.DEFAULT\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d "0" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Desktop" /v "MouseWheelRouting" /t REG_DWORD /d "0" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "Beep" /t REG_SZ /d "No" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "ExtendedSounds" /t REG_SZ /d "No" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Sound" /v "Beep" /t REG_SZ /d "no" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Sound" /v "ExtendedSounds" /t REG_SZ /d "no" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d "0" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Desktop" /v "MouseWheelRouting" /t REG_DWORD /d "0" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "Beep" /t REG_SZ /d "No" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "ExtendedSounds" /t REG_SZ /d "No" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Sound" /v "Beep" /t REG_SZ /d "no" /f 
Reg.exe add "HKU\.DEFAULT\Control Panel\Sound" /v "ExtendedSounds" /t REG_SZ /d "no" /f 
Reg.exe add "HKCU\Control Panel\Mouse" /v "ActiveWindowTracking" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "Beep" /t REG_SZ /d "No" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "DoubleClickHeight" /t REG_SZ /d "4" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "DoubleClickSpeed" /t REG_SZ /d "500" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "DoubleClickWidth" /t REG_SZ /d "4" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "ExtendedSounds" /t REG_SZ /d "No" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseHoverHeight" /t REG_SZ /d "4" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseHoverWidth" /t REG_SZ /d "4" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseTrails" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000000000c0cc0c0000000000809919000000000040662600000000000033330000000000" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "0000000000000000000038000000000000007000000000000000a800000000000000e00000000000" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "SnapToDefaultButton" /t REG_SZ /d "0" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "SwapMouseButtons" /t REG_SZ /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorSpeed" /v "CursorSensitivity" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorSpeed" /v "CursorUpdateInterval" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorSpeed" /v "IRRemoteNavigationDelta" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism" /v "AttractionRectInsetInDIPS" /t REG_DWORD /d "5" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism" /v "DistanceThresholdInDIPS" /t REG_DWORD /d "40" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism" /v "MagnetismDelayInMilliseconds" /t REG_DWORD /d "50" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism" /v "MagnetismUpdateIntervalInMilliseconds" /t REG_DWORD /d "16" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism" /v "VelocityInDIPSPerSecond" /t REG_DWORD /d "360" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "8" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f

echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU


:data

cls
echo.
echo.
echo.

echo.
echo.                                                             !DATA QUEUE SIZE!
echo.                   "=================================================================================================="                        
echo.                      O Data Queue Size diminui o atraso de entrada, mas causara atraso do mouse e do kb em PCs fraco 
echo.                                Quanto menor o numero, menor o atraso do mouse, mas mais lag em pcs ruins   
echo.    
echo.                                      Recomendacoes:  PC Fraco: 20  PC Medio: 17   PC Bom: 14!                                                               
echo.
echo.
echo.                                       [1] 14                    [2] 15                 [3] 16           
echo.                                                                                                     
echo.                                       [4] 17                    [5] 18                 [6] 19           
echo.                                                                                                     
echo.                                       [7] 20                    [8] 25                 [9] 30           
echo.
echo.                                       [10] Kb manual            [11] Mouse manual      [R] Revert 
echo.                                                                                                          
echo.                                                           
echo.                                                          Pressione "X" para voltar ao menu
echo.                                                                    
echo.                   "=================================================================================================="
echo.

set /p input=: 
if /i %input% == 1 goto 14
if /i %input% == 2 goto 15
if /i %input% == 3 goto 16
if /i %input% == 4 goto 17
if /i %input% == 5 goto 18
if /i %input% == 6 goto 19
if /i %input% == 7 goto 20
if /i %input% == 8 goto 25
if /i %input% == 9 goto 30
if /i %input% == 10 goto keyb
if /i %input% == 11 goto mous
if /i %input% == R goto Revert
if /i %input% == X cls & goto MENU

) ELSE (
echo Entrada invalida & goto MisspellRedirect

:MisspellRedirect
cls
echo Misspell Detected
timeout 2 > nul
goto Redirectmouse


:Redirectmouse
cls
echo Wait.
timeout 1 > nul
cls
echo Wait..
timeout 1 > nul
cls
echo Wait...
timeout 1 > nul
goto :MENU



:14
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "20" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "20" /f

echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU

:15

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "21" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "21" /f

echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU

:16

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "22" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "19" /f

echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU

:17

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "23" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "23" /f

echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU

:18

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "24" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "24" /f

echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU

:19

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "25" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "25" /f

echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU

:20

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "32" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "32" /f

echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU

:25

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "37" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "37" /f

echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU

:30

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "48" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "48" /f

echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU


:revert

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "80" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "80" /f
echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU

:mous

REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit /v LastKey /t REG_SZ /d Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters /f
START regedit
echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU


:keyb

REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit /v LastKey /t REG_SZ /d Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters /f
START regedit
echo.
echo Tweaks aplicados com sucesso
echo.
echo                                                        Pressione ENTER para continuar...     
pause >nul
cls
goto :MENU