@Echo Off
Rem Modify a signaldefinition of a route due to modification-commands.
Rem Minimum version of TSUtil required is >>TSUtil V3.4.08(F)<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if X%2==X goto .help
if "%TrSimPath%"=="" goto .trsim
if "%TSUtil%"=="" goto .trsim
if NOT EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .route
if EXIST "%TrSimPath%\Routes\%1\%2\chgSig.dat" goto .exec
Echo Attention: File of modification-commands '%2/chgSig.dat' not found!
Echo            Please insert controlfile into control-directory within '%TrSimPath%/Routes/%1'.
goto .ende
:.help
Echo Attention: chgSig-1 "<route>" "<verz>"
Echo            "<route>" refers to the RELATIVE path to the route (z.B: Europe1)".
Echo            "<verz>" refers to the RELATIVE path to the control-directory.
goto .ende
:.trsim
Echo Attention: TSUtil is NOT initialized correctly.
Echo            Please delete TSUtil and install stand-alone-version of TSUitil (V3.4.08 F) again.
goto .ende
:.route
Echo Error: Route '%TrSimPath%/Routes/%1' is NOT available!
Echo        Please check reference to affected route (relative reference).
goto .ende
:.exec
java -Xmx512M -cp %TSUtil% TSUtil -$B "-l%3" chgSig -inplace "%2" "%TrSimPath%/Routes/%1" 
if NOT %ERRORLEVEL%==0 goto .error
REM Create integrity within the (temporary) created route-definition.
java -Xmx512M -cp %TSUtil% TSUtil -$B "-L%3" rendb -a -r -w -inplace "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Error -- Program reported errorcode %ERRORLEVEL%!
:.ende
Echo.
Echo Procedure ended (successfully)!