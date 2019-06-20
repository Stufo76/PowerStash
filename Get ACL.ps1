$browse = New-Object System.Windows.Forms.FolderBrowserDialog
$browse.ShowNewFolderButton = $false
$browse.SelectedPath = "U:\"
$browse.Description = "Select a directory"
$browse.ShowDialog()
pause
    #Stores the selected location
$Location = $browse.SelectedPath

$FolderPath = Get-ChildItem -Directory -Path $browse.SelectedPath -Force
$Output = @()
ForEach ($Folder in $FolderPath) {
$Acl = Get-Acl -Path $Folder.FullName
ForEach ($Access in $Acl.Access) {
$Properties = [ordered]@{'Folder Name'=$Folder.FullName;'Group/User'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited}
$Output += New-Object -TypeName PSObject -Property $Properties            
}
}
$Output | Out-GridView