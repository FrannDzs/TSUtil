@Echo off
del *.class
REM Compilieren der Java-Anwendung CpyReg
javac CpyReg.java
if %ERRORLEVEL%==0 goto .copy
echo "Fehler beim Kompilieren Java-Programm CpyReg"
:.copy


