@Echo Off
Rem Convert a route, where Overheadwire has been suppressed using 'SectionIDX'-mode (SectionIDX=150)
Rem Attention: Tracks, where overheadwire has been suppressed are marked with StaticDetailLevel '1'
REM            and suppression is removed.
Rem Minimum version of TSUtil required is >>TSUtil V3.4.09A<<
Rem
if X%1==X goto .help
if /I "%1"=="Help" goto .help
if "%TrSimPath%"=="" goto .trsim
if "%TSUtil%"=="" goto .trsim
if EXIST "%TrSimPath%\Routes\%1\%1.trk" goto .exec
Echo Error: Route '%TrSimPath%/Routes/%1' is NOT available!
Echo        Please check reference to affected route (relative reference).
goto .ende
:.help
Echo Activation: cvrt-1 "<route>"
Echo             "<route>" refers to the RELATIVE path to the route (z.B: Europe1)".
goto .ende
:.trsim
Echo Attention: TSUtil is NOT initialized correctly.
Echo            Please delete TSUtil and install stand-alone-version of TSUitil (V3.4.09A) again.
goto .ende
:.exec
java -Xmx512M -cp %TSUtil% TSUtil -$B "-l%2" fcpy -w "-m\"SectionIdx ( 150 )\":\"SectionIdx ( 4294967280 )\""^
 "-m\"SectionIdx ( 39887 )\":\"SectionIdx ( 4294967280 )\""^
 "%TrSimPath%/Routes/%1/World" "%TrSimPath%/Routes/%1/World" 
if NOT %ERRORLEVEL%==0 goto .error
Echo Attention: Tracks, where overheadwire has been suppressed are marked with StaticDetailLevel '1'.
java -Xmx512M -cp %TSUtil% TSUtil -$B "-L%2" -j1:2 cvrt -inplace "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Error -- Program reported errorcode %ERRORLEVEL%!
:.ende
Echo.
Echo Procedure ended (successfully)!