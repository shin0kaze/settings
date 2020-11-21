

# *** Documentation *** #

<#
	This script intended for sync settings
	from different programing software
	till it's all now
#>

# *** Definition *** #

$prompt = @"
l			- show list of Programs
c "name"	- copy settings to repo
ca			- copy all settings to repo
r "name"	- restore settings from repo
ra			- restore all settings from repo
a			- add a settings to repo
g "msg"		- add -> commit -> push
q			- quit from script
v			- write all variables
p			- see a prompt again
"@

$told = New-Object -TypeName psobject
$told | Add-Member -MemberType NoteProperty -Name c_text -Value "Settings copied successful"
$told | Add-Member -MemberType NoteProperty -Name r_text -Value "Settings restored successful"
$told | Add-Member -MemberType NoteProperty -Name e_text -Value "Command ends with some errors"
$told | Add-Member -MemberType NoteProperty -Name a_text -Value "Adding was successful"
$told | Add-Member -MemberType NoteProperty -Name g_text -Value "Pushing to repo was were successful"
$told | Add-Member -MemberType NoteProperty -Name u_text -Value "Unknown command try it again"
$told | Add-Member -MemberType NoteProperty -Name p_text -Value "Write command below"

$data_ini = Get-Content se.json | ConvertFrom-Json
$data_ini | Add-Member -MemberType NoteProperty -Name appdata -Value $env:APPDATA
$data_ini | Add-Member -MemberType NoteProperty -Name appdata_l -Value $env:LOCALAPPDATA
$tmp = [Environment]::GetFolderPath("MyDocuments") | Out-String
$data_ini | Add-Member -MemberType NoteProperty -Name docus -Value $tmp 

$dirs = @()

# *** Functions *** #

function LN
{
Write-Host "`n"
}
function Show-ListOfPrograms
{
	$len = $dirs.length;
	Write-Host "| ID  |  NAME  |"
	for($i = 0; $i -lt $len; $i++)
	{
		Write-Host " " $i ".	" $dirs[$i]
	}
}
function Copy-OneSettings($name)
{
	
}
function Copy-AllSettings
{
	
}
function Restore-OneSettings($name)
{
	
}
function Restore-AllSettings
{
	
}
function Add-OneSettings
{
	
}
function Push-ChangesToRepo($message)
{
	$message
	if ((Get-Variable -Name "message" -Scope "Local" -ErrorAction "Ignore") -eq $null) {}
	else {$message="default message"
	Write-Host "what!"
	}
	git status
	echo `" $message `"

	#git add *
	#git commit -m `"$message`"
	#git push
}
function Finalize-Script
{
	exit
}
function Write-Variablesl
{ 
	$dirs
	Write-Host "data_ini `n"
	$data_ini | Get-Member | ForEach-Object {"`t" + $_ + "`n"} | Write-Host
	Write-Host "told `n"
	$told | Get-Member | ForEach-Object {"`t" + $_ + "`n"} | Write-Host
}
function Show-Prompt
{
	$prompt
}
function Reload-Directories
{
	$script:dirs = Get-ChildItem ".\" -directory | select Name | Format-Table -HideTableHeaders | Out-String `
	 | ForEach-Object {$_ -split"`n", 0, "multiline"}
	$script:dirs = $script:dirs | Where-Object {($_) -and ($_ -ne "") -and ($_ -ne "`n") -and ($_ -ne "`r`n") -and ($_ -ne "`r")}
}

# *** Execution *** #

Reload-Directories
Show-Prompt

if($args.length -lt 1) {$command = Read-Host $told.p_text}
 else {$command = $args}

while($true)
{ 
	$argus = [regex]::Split( $command, ' (?=(?:[^"]|"[^"]*")*$)' )
	switch($argus[0]) 
	{
		"l"		{Show-ListOfPrograms}
		"c"		{Copy-OneSettings}
		"ca"	{Copy-AllSettings}
		"r"		{Restore-OneSettings}
		"ra"	{Restore-AllSettings}
		"a"		{Add-OneSettings}
		"g"		{Push-ChangesToRepo $argus[1]}
		"q"		{Finalize-Script}
		"v"		{Write-Variables}
		"p"		{Show-Prompt}
		default	{$told.u_text}	
	}
	$command = Read-Host $told.p_text
}

Write-Host "What you did here?"
pause
Finalize-Script 

# *** Some Garbage *** #

#$data_ini.appdata = $ExecutionContext.InvokeCommand.ExpandString($data_ini.appdata) not need now
#if ((gv message -s global -ea ig) -ne $null)