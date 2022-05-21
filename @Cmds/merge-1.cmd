@Echo OFF
Rem Mischen zweier Strecken (inclusiv Signaldefinitionen)
Rem Benutzung dieser Prozedur ab >>TSUtil V3.4.08<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if X%2==X goto .help
if "%TrSimPath%"=="" goto .trsim
if NOT EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .rte
if EXIST "%TrSimPath%\Routes\%2\%2.trk" goto .exec
Echo Fehler: Route '%TrSimPath%/Routes/%2' wurde NICHT gefunden!
Echo         Bitte ueberpruefen Sie die obige Referenz auf die Route.
goto .ende
:.help
Echo Aufruf: merge-1 "<route1>" "<route2>"
Echo         "<route1>" ist der RELATIVE Name der Basis-Route (z.B: Europe1)"
Echo         "<route2>" ist der RELATIVE Name der einzumischenden Route"
goto .ende
:.trsim
Echo Achtung: System ist NICHT korrekt initialisiert
Echo          Bitte TSUtil loeschen und Installation (V3.4.08) wiederholen
goto .ende
:.rte
Echo Fehler: Route '%TrSimPath%/Routes/%1' wurde NICHT gefunden!
Echo         Bitte ueberpruefen Sie die obige Referenz auf die Strecke.
goto .ende
:.exec
java -Xmx512M -cp . TSUtil -$B "-l%3" merge -p "%TrSimPath%/Routes/%1" "%TrSimPath%/Routes/%2"
Set EL=%ERRORLEVEL%
if NOT %EL%==0 goto .error
Set /A EL=101
if NOT EXIST "%TrSimPath%\Routes\%1\NewRoute\World" goto .error
Del /Q %TrSimPath%\Routes\%1\World\*
Copy %TrSimPath%\Routes\%1\NewRoute\World\* %TrSimPath%\Routes\%1\World\
Set /A EL=102
if NOT EXIST "%TrSimPath%\Routes\%1\NewRoute\TD" goto .error
Del /Q %TrSimPath%\Routes\%1\TD\*
Copy %TrSimPath%\Routes\%1\NewRoute\TD\* %TrSimPath%\Routes\%1\TD\
Set /A EL=103
if NOT EXIST "%TrSimPath%\Routes\%1\NewRoute\Tiles" goto .error
Del /Q %TrSimPath%\Routes\%1\Tiles\*
Copy %TrSimPath%\Routes\%1\NewRoute\Tiles\* %TrSimPath%\Routes\%1\Tiles\
if NOT EXIST "%TrSimPath%\Routes\%1\NewRoute\LO_Tiles" goto .cont1
Del /Q %TrSimPath%\Routes\%1\LO_Tiles\*
Copy %TrSimPath%\Routes\%1\NewRoute\LO_Tiles\* %TrSimPath%\Routes\%1\LO_Tiles\
:.cont1
if NOT EXIST "%TrSimPath%\Routes\%1\NewRoute\Paths" goto .cont2
Del /Q %TrSimPath%\Routes\%1\Paths\*
Copy %TrSimPath%\Routes\%1\NewRoute\Paths\* %TrSimPath%\Routes\%1\Paths\
:.cont2
Set /A EL=104
if NOT EXIST "%TrSimPath%\Routes\%1\NewRoute\Sound" goto .error
Copy %TrSimPath%\Routes\%1\NewRoute\Sound\* %TrSimPath%\Routes\%1\Sound\
Echo.
XCopy %TrSimPath%\Routes\%1\NewRoute\Shapes\* %TrSimPath%\Routes\%1\Shapes /S /Y
XCopy %TrSimPath%\Routes\%1\NewRoute\Textures\* %TrSimPath%\Routes\%1\Textures /S /Y
XCopy %TrSimPath%\Routes\%1\NewRoute\Terrtex\* %TrSimPath%\Routes\%1\Terrtex /S /Y
Copy /Y %TrSimPath%\Routes\%1\NewRoute\* %TrSimPath%\Routes\%1\
RD /S /Q %TrSimPath%\Routes\%1\NewRoute
:.error
Echo Fehler -- Programm endete mit ReturnCode %EL%!
:.ende
Echo.
Echo Die Kommandoprozedur wurde beendet!