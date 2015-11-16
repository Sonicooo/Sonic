@echo off
REM Recompress Nemesis-compressed 8x8 level data to Kosinski-compressed for S2 art loader
echo Decompressing Nemesis files...
REM Have to use KENSSharp because Nemesis decompression doesn't work with derecmp
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - GHZ1.bin" "artkos_u/8x8 - GHZ1.bin"
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - GHZ2.bin" "artkos_u/8x8 - GHZ2.bin"
cd artkos_u
copy "8x8 - GHZ1.bin" /B + "8x8 - GHZ2.bin" /B "8x8 - GHZ.bin" /B >nul
del "8x8 - GHZ1.bin"
del "8x8 - GHZ2.bin"
cd ..
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - LZ.bin" "artkos_u/8x8 - LZ.bin"
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - MZ.bin" "artkos_u/8x8 - MZ.bin"
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - SBZ.bin" "artkos_u/8x8 - SBZ.bin"
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - SLZ.bin" "artkos_u/8x8 - SLZ.bin"
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - SYZ.bin" "artkos_u/8x8 - SYZ.bin"
echo Done. Recompressing to Kosinski...
derecmp.exe kc "artkos_u" "artkos"
echo Done.
pause