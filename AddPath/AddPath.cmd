@Echo off
del *.class
REM Compilieren der Java-Anwendung AddPath
javac AddPath.java
if %ERRORLEVEL%==0 goto .copy
echo "Fehler beim Kompilieren Java-Programm AddPath"
:.copy


