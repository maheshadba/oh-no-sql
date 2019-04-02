param($password)
$dbdestination = "C:\SQLDATA\OpenHack.bak"
# Setup the data, backup and log directories as well as mixed mode authentication
Import-Module "sqlps" -DisableNameChecking
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
$sqlesq = new-object ('Microsoft.SqlServer.Management.Smo.Server') Localhost
$sqlesq.Settings.LoginMode = [Microsoft.SqlServer.Management.Smo.ServerLoginMode]::Mixed
$sqlesq.Settings.DefaultFile = $data
$sqlesq.Settings.DefaultLog = $logs
$sqlesq.Settings.BackupDirectory = $backups
$sqlesq.Alter() 

# Restart the SQL Server service
Restart-Service -Name "MSSQLSERVER" -Force
# Re-enable the sa account and set a new password to enable login
Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER LOGIN sa ENABLE" 
$pwd = $password
$pwd.Insert(0, "'")
$pwd += "'"

Invoke-Sqlcmd -ServerInstance LABVM -Database "master" -Query "ALTER LOGIN sa WITH PASSWORD = $pwd"


Restore-SqlDatabase -ServerInstance LABVM -Database "OpenHack" -BackupFile "C:\SQLDATA\OpenHack.bak"