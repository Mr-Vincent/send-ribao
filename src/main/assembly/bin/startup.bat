
REM check JAVA_HOME & java
set "JAVA_CMD=%JAVA_HOME%/bin/java"
if "%JAVA_HOME%" == "" goto noJavaHome
if "%1"==""  goto noParam
if exist "%JAVA_HOME%\bin\java.exe" goto mainEntry
:noParam
echo ---------------------------------------------------
echo WARN: config file variable is not set.
echo ---------------------------------------------------

:noJavaHome
echo ---------------------------------------------------
echo WARN: JAVA_HOME environment variable is not set. 
echo ---------------------------------------------------
set "JAVA_CMD=java"
:mainEntry
REM set HOME_DIR
set "CURR_DIR=%cd%"
cd ..
set "SERVICE_HOME=%cd%"
cd %CURR_DIR%
"%JAVA_CMD%" -server -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000 -Xms1G -Xmx2G -XX:MaxPermSize=64M  -XX:+AggressiveOpts -XX:MaxDirectMemorySize=1G -DMYCAT_HOME=%SERVICE_HOME% -cp "..\conf;..\lib\*" top.weidong.mail.SendMail %1
pause