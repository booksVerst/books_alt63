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

call "../Parser/Engine/FTSGenerator.exe" "project_main.sproj" "Data/configs/Config.fts"

atomic_fixer.py

for %%f in (*.sproj) do (
	call "../Parser/Engine/Compiler.exe" "%%f"
)

call "../Parser/Parser/Utilities/7zip/7za.exe" a -tzip -ssw -mx5 -r0 -x@"../Parser/Parser/Utilities/7zip/exclusions.txt" 0000035D.zip

rem clean trash, needed for build only
call clean.bat

pause
endlocal