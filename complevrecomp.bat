@echo off
REM Recompress Nemesis-compressed 8x8 level data to Kosinski-compressed for S2 art loader
echo Decompressing Nemesis files...
REM Have to use KENSSharp because Nemesis decompression doesn't work with derecmp
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - GHZ1.bin" "artcomp_u/8x8 - GHZ1.bin"
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - GHZ2.bin" "artcomp_u/8x8 - GHZ2.bin"
cd artcomp_u
copy "8x8 - GHZ1.bin" /B + "8x8 - GHZ2.bin" /B "8x8 - GHZ.bin" /B >nul
del "8x8 - GHZ1.bin"
del "8x8 - GHZ2.bin"
cd ..
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - LZ.bin" "artcomp_u/8x8 - LZ.bin"
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - MZ.bin" "artcomp_u/8x8 - MZ.bin"
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - SBZ.bin" "artcomp_u/8x8 - SBZ.bin"
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - SLZ.bin" "artcomp_u/8x8 - SLZ.bin"
"_comp/KensSharp.exe" --decompress=Nemesis "artnem/8x8 - SYZ.bin" "artcomp_u/8x8 - SYZ.bin"
echo Done. Recompressing to Comper...
"_comp/compcmp.exe" "artcomp_u/8x8 - GHZ.bin" "artcomp/8x8 - GHZ.bin"
"_comp/compcmp.exe" "artcomp_u/8x8 - LZ.bin" "artcomp/8x8 - LZ.bin"
"_comp/compcmp.exe" "artcomp_u/8x8 - MZ.bin" "artcomp/8x8 - MZ.bin"
"_comp/compcmp.exe" "artcomp_u/8x8 - SBZ.bin" "artcomp/8x8 - SBZ.bin"
"_comp/compcmp.exe" "artcomp_u/8x8 - SLZ.bin" "artcomp/8x8 - SLZ.bin"
"_comp/compcmp.exe" "artcomp_u/8x8 - SYZ.bin" "artcomp/8x8 - SYZ.bin"
echo Done.
pause