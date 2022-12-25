@echo off
color 0a
cd ..
echo BUILDING GAME
haxelib run lime test windows -release
echo.
echo done.
pause
pwd
explorer.exe export\release\windows\bin