��
@echo off

cls
title Removedor do GameBarPresenceWriter by zJu4nn

echo Removendo o GameBarPresenceWriter...
echo.

takeown /f "C:\Windows\System32\GameBarPresenceWriter.exe"
icacls "C:\Windows\System32\GameBarPresenceWriter.exe" /grant Administrators:F
del "C:\Windows\System32\GameBarPresenceWriter.exe"

echo.
echo GameBarPresenceWriter Removido!
echo.
pause
exit
