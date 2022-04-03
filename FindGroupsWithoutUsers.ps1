Function FindGroupsWithoutUsers {
    $AllGroups = Get-ADGroup -Filter *
    Write-Host "List of groups without users:"
    $Count = 0
    foreach($Group in $AllGroups) {
        $Users = Get-ADGroupMember -Identity $Group -Recursive | where {$_.objectclass -eq 'user'}
        if(!$Users) {
            $Group | select Name, DistinguishedName
            $Count++
        }
    }
    if($Count -eq 0) {
        Write-Host "`n`n`nThere are no groups without users!`n`n`n"
    } else {
        Write-Host "`n`n`n Found $Count group(s) without users!`n`n`n"
    }
}

FindGroupsWithoutUsers
timeout /t -1
