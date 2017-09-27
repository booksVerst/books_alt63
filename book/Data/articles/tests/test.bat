@echo off
setlocal EnableDelayedExpansion
set i=0
for %%a in (*.xml) do (
    set /a i+=1
    ren "%%a" "test_!i!.xml"
)