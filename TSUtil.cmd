@Echo off
REM Version 3.7.00
del *.class
REM Compilieren der Java-Anwendung TSUtil
javac TSUtil.java
if %ERRORLEVEL%==0 goto .copy
echo "Fehler beim Kompilieren Java-Programm TSUtil"
goto .ende
:.copy
REM Verfuegbarkeit von 'CpyReg'/'AddPath' herstellen
copy .\@Cmds\*.class
REM Verfuegbarkeit der Kommandoprozeduren herstellen
copy .\@Cmds\*.cmd
copy .\@Cmds\en\*.cmd en
REM Zusammenstellen der Daten
del classes\*.class
del classes\*.properties
del classes\TSUtil*.txt
copy *.class classes
copy *.properties classes
copy TSUtil*.txt classes
copy @Cmds\*.cmd classes
copy @Cmds\en\*.cmd classes\en
REM Packen der Java-Anwendung TSUtil
cd classes
jar cvfm TSUtil.jar manifest.txt .
copy TSUtil.jar ..
cd ..
:.ende

