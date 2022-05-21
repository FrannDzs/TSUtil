@Echo Off
Rem Conversion of a route including suppress of the overheadwirde using 'SectionIDX'-method.
Rem Modification of track-objects due to current 'StaticDetailLevel'.
Rem Following 'StaticDetailLevel' are concerned. (all others are not modified)
Rem	0 - Do not modify normal electrified track
Rem	1 - Suppress overheadwire using 'SectionIDX'-method (151) 
Rem	2 - Replace trackshape-reference and suppress overheadwire (use "<kng>", 152) 
Rem	4 - Replace trackshape-reference ("<kng>"). DO NOT suppress overheadwire. 
Rem Minimum version of TSUtil required is >>TSUtil V3.4.08<<
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
Echo Activation: cvrt-4 "<route>" "<kng>"
Echo             "<route>" refers to the RELATIVE path to the route (z.B: Europe1)"
Echo             "<kng>" selected prefix used with textures and additional shapes (z.B. 'NB')"
goto .ende
:.trsim
Echo Attention: TSUtil is NOT initialized correctly.
Echo            Please delete TSUtil and install stand-alone-version of TSUitil (V3.4.08) again.
goto .ende
:.exec
java -Xmx512M -cp %TSUtil% TSUtil -$B "-l%3" -p2:%2Shapes cvrt -r -inplace -f1:151 -f2:152:2:A:%2^
 -M4:2:A(.*)\.s:%2$1.s "%TrSimPath%/Routes/%1"
if %ERRORLEVEL%==0 goto .ende
:.error
Echo Error -- Program reported errorcode %ERRORLEVEL%!
:.ende
Echo.
Echo Procedure ended (successfully)!