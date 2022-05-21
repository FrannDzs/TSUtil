@Echo On
Rem Convert a route and adjust it to the XTrack-definition of global tsection.dat.
Rem Minimum version of TSUtil required is >>TSUtil V3.4.04<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if "%TrSimPath%"=="" goto .trsim
if "%TSUtil%"=="" goto .trsim
if NOT EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .route
if EXIST "%TrSimPath%\Routes\tsection.dat" goto .exec
Echo Attention: Original version of 'tsection.dat' not found.
Echo            Please copy ORIGINAL version of (global) 'tsection.dat' to '%TrSimPath%/Routes'.
goto .ende
:.help
Echo Activation: cvrt-2 "<route>"
Echo             "<route>" refers to the RELATIVE path to the route (z.B: Europe1)"
Echo             The ORIGINAL version of (global) 'tsection.dat' must exist within '%TrSimPath%/Routes'.
goto .ende
:.trsim
Echo Attention: TSUtil is NOT initialized correctly!
Echo            Please delete TSUtil and install stand-alone-version of TSUitil (V3.4.04) again.
goto .ende
:.route
Echo Error: Route '%TrSimPath%/Routes/%1' was NOT found! (*.trk-file missing)
Echo        Please check the reference to the selected route.
goto .ende
:.exec
java -Xmx512M -cp %TSUtil% TSUtil -$B "-l%2" cvrt "-b%TrSimPath%/Routes/tsection.dat" -v99:99 -inplace "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
Echo Error -- Program reported errorcode %ERRORLEVEL%!
:.ende
Echo.
Echo Procedure ended (successfully)!