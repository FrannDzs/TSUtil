@Echo Off
Rem Create an alternative version of track-definitions
Rem Minimum version of TSUtil required is >>TSUtil V3.4.08<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if "%TrSimPath%"=="" goto .trsim
if "%TSUtil%"=="" goto .trsim
if /I NOT "%1"=="A" goto .exec
Echo Error: Prefix 'A' is NOT allowed (original prefix)
Echo        Please select an other prefix for track-definitions.
goto .ende
:.help
Echo Activation: fcpy-1 "<kng>"
Echo             "<kng>" selected prefix, must match prefix used with textures (z.B. 'NB')"
goto .ende
:.trsim
Echo Attention: TSUtil is NOT initialized correctly.
Echo            Please delete TSUtil and install stand-alone-version of TSUitil (V3.4.08) again.
goto .ende
:.exec
java -Xmx512M -cp %TSUtil% TSUtil -$B "-l%2" fcpy -s -o "-f^A(\d)(.*)\.s$" -z%1$1$2.s -mAClean:%1Clean -mATrack:%1Track^
 "%TrSimPath%/Global/Shapes" "%TrSimPath%/Global/Shapes/%1Shapes"
if NOT %ERRORLEVEL%==0 goto .error
java -Xmx512M -cp %TSUtil% TSUtil -$B "-L%2" fcpy -u "-f^A(\d)(.*)\.sd$" -z%1$1$2.sd -M(.*)A(\d)(.*)\.s:$1%1$2$3.s^
 "%TrSimPath%/Global/Shapes" "%TrSimPath%/Global/Shapes/%1Shapes"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Error -- Program reported errorcode %ERRORLEVEL%!
:.ende
Echo.
Echo Procedure ended (successfully)!
