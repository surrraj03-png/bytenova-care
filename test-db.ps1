# ByteNova Care – Live MySQL 8 JDBC Integration Test Runner
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host "  ByteNova Care – Live MySQL 8 JDBC Integration Test" -ForegroundColor Cyan
Write-Host "=====================================================================" -ForegroundColor Cyan

$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
$cp = "target\classes;target\bytenova-care\WEB-INF\lib\*"

& "C:\Program Files\Java\jdk-21\bin\java.exe" -cp $cp com.bytenova.care.util.DatabaseTestRunner
