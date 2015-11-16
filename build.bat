@ECHO OFF

REM // make sure we can write to the file s1built.bin
REM // also make a backup to s1built.prev.bin
IF NOT EXIST s1built.bin goto LABLNOCOPY
IF EXIST s1built.prev.bin del s1built.prev.bin
IF EXIST s1built.prev.bin goto LABLNOCOPY
move /Y s1built.bin s1built.prev.bin
IF EXIST s1built.bin goto LABLERROR2
:LABLNOCOPY

REM // clear the output window
cls

REM // run the assembler
asm68k /k /p /o ae- sonic.asm, s1built.bin >sonic.log, , 

REM // done -- pause if we seem to have failed, then exit
IF NOT EXIST s1built.bin goto LABLPAUSE
fixheader s1built.bin
exit /b

pause


exit /b

:LABLPAUSE
REM // display a noticeable message
echo.
echo *************************************************************************
echo *                                                                       *
echo *   ROM ASSEMBLING FAILED, PLEASE SEE sonic.log FOR ERROR DETAILS       *
echo *                                                                       *
echo *************************************************************************
echo.
pause

