@echo off
REM Uncompress map16 and map256 to map16_u and map256_u, respectively
echo Decompressing map16 files...
derecmp.exe ed "map16" "map16_U"
echo Done. Decompressing map256 files...
derecmp.exe kd "map256" "map256_U"
echo Done.