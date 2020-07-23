@echo off
setlocal enableextensions enabledelayedexpansion
set PATH=%SystemRoot%\System32

rem Find version number from resource file
for /f "tokens=3" %%a in ('type icyd.rc ^| %SystemRoot%\System32\find "ProductVersion"') do set ver=%%~a
for /f "tokens=1-3 delims=.,\" %%a in ("%ver%") do (
    set major=%%a
    set major=!major:"=!
    for %%x in (!major!) do set major=%%x
    set minor=%%b
    set minor=!minor:"=!
    for %%y in (!minor!) do set minor=%%y
    set build=%%c
    set build=!build:"=!
    for %%z in (!build!) do set build=%%z
)

rem Do this outside Makefile since NMake has problems extracting version numbers
del /q icyd-!major!_!minor!_!build!-i386.exe 2>NUL
del /q icyd-!major!_!minor!_!build!.ddf 2>NUL
del /q icyd-!major!_!minor!_!build!-src-winnt.cab 2>NUL
del /q launcher-!major!_!minor!_!build!.pdb 2>NUL
del /q icyd-!major!_!minor!_!build!.zap 2>NUL

if /i not "%1"=="clean" (
   if not exist icyd.exe (
      call build-layout.bat all
   )
   copy /y icyd.exe icyd-!major!_!minor!_!build!-i386.exe
   copy /y launcher.pdb launcher-!major!_!minor!_!build!.pdb
   copy /y icyd.zap icyd-!major!_!minor!_!build!.zap

   set files=build-layout.bat build-installer.bat Makefile sources README.txt launcher.c
   for %%a in (c def inf mak rc reg sed zap) do set files=!files! icyd.%%a

   @copy /y NUL icyd-!major!_!minor!_!build!.ddf
   @echo .Option Explicit >> icyd-!major!_!minor!_!build!.ddf
   @echo .Set CabinetNameTemplate=icyd-!major!_!minor!_!build!-src-winnt.cab >> icyd-!major!_!minor!_!build!.ddf
   @echo .Set CompressionType=LZX >> icyd-!major!_!minor!_!build!.ddf
   @echo .Set CompressionMemory=21 >> icyd-!major!_!minor!_!build!.ddf
   @echo .Set DiskDirectoryTemplate=. >> icyd-!major!_!minor!_!build!.ddf
   @echo .Set InfFileName=NUL >> icyd-!major!_!minor!_!build!.ddf
   @echo .Set RptFileName=NUL >> icyd-!major!_!minor!_!build!.ddf
   @for %%a in (!files!) do @echo %%a >> icyd-!major!_!minor!_!build!.ddf
   makecab /F icyd-!major!_!minor!_!build!.ddf
)
endlocal
