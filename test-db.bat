@echo off
echo =====================================================================
echo   ByteNova Care – Live MySQL 8 JDBC Integration Test
echo =====================================================================

set JAVA_HOME=C:\Program Files\Java\jdk-21
set CP=target\classes;target\bytenova-care\WEB-INF\lib\*

echo Running DatabaseTestRunner with classpath %CP%...
"%JAVA_HOME%\bin\java.exe" -cp "%CP%" com.bytenova.care.util.DatabaseTestRunner

pause
