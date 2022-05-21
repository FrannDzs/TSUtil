@Echo Off
Rem Execute 'ichK' and check integrity of a route.
Rem Minimum version of TSUtil required is >>TSUtil V3.4.04<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if "%TrSimPath%"=="" goto .trsim
if "%TSUtil%"=="" goto .trsim
if EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .exec
Echo Error: Route '%TrSimPath%/Routes/%1' was NOT found! (*.trk-file missing)
Echo        Please check the reference to the selected route.
goto .ende
:.help
Echo Activation: ichk "<route>"
Echo             "<route>" refers to the RELATIVE path to the route (z.B: Europe1)",
goto .ende
:.trsim
Echo Attention: TSUtil is NOT initialized correctly.
Echo            Please delete TSUtil and install stand-alone-version of TSUitil (V3.4.04) again.
goto .ende
:.exec
java -Xmx512M -cp %TSUtil% TSUtil -$B "-l%2" ichk -S "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
Echo Error -- Program reported errorcode %ERRORLEVEL%!
:.ende
Echo.
Echo Procedure ended (successfully)!