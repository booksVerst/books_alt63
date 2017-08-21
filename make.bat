@echo off
setlocal enabledelayedexpansion

if exist *.datf del *.datf
if exist *.log del *.log
if exist *.sproj del *.sproj

call "../Parser/Parser/Charon/x64/Release/Charon.exe" "Data/configs/config.cfg"
rem convert tex
set articles=
for %%f in (Articles\*.xml) DO	set articles=!articles! %%f
call "../Parser/Parser/FrontTexReplacer/Release/FrontTexReplacer.exe" %articles%

for %%f in (*.sproj) do (
	call "../Parser/Engine/Compiler.exe" "%%f" -c1
)

rem clean trash, needed for build only
call clean.bat

pause