@echo off
rem echo ### COMPILANDO SCRIPT ###
cd ..\script
rem no olvides cambiar NPANT por el nº de pantallas
msc redplanet.spt msc.h 30
copy *.h ..\dev
cd ..\dev
rem echo -------------------------------------------------------------------------------
rem echo ### REGENERANDO MAPA ###
cd ..\map
rem cambia ANCHO y ALTO por los valores de tu mapa:
..\utils\mapcnv mapa.map 5 6 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
rem echo -------------------------------------------------------------------------------
echo ### COMPILANDO ###
zcc +zx -vn redplanet.c -o redplanet.bin -lndos -lsplib2 -zorg=24200
echo -------------------------------------------------------------------------------
echo ### CONSTRUYENDO CINTA ###
rem cambia LOADER por el nombre que quieres que salga en Program:
..\utils\bas2tap -a10 -sREDPLANET loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 24200 redplanet.bin
copy /b loader.tap + screen.tap + main.tap redplanet.tap
echo -------------------------------------------------------------------------------
echo ### LIMPIANDO ###
del loader.tap
del screen.tap
del main.tap
del redplanet.bin
echo -------------------------------------------------------------------------------
echo ### DONE ###
