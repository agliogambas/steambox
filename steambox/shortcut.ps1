$dir = 'C:\Program Files (x86)\Steam\steamapps'
$desktopPath = [Environment]::GetFolderPath("Desktop")

$shell = New-Object -ComObject WScript.Shell

$appManifests = Get-ChildItem -Path $dir -Filter 'appmanifest_*.acf' -File

function Remove-StringFromLine {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath,
        
        [Parameter(Mandatory=$true)]
        [string]$TargetString
    )

    $fileContent = Get-Content $FilePath

    foreach ($line in $fileContent) {
        if ($line.Contains($TargetString)) {
            $cleanedString = $line -replace $TargetString, ""
            $cleanedString = [regex]::Replace($cleanedString, '(?<=^([^"]*"[^"]*")*[^"]*)\s', '')
            $cleanedString = $cleanedString -replace '"', ""

            return $cleanedString
        }
    }
}

function FindIconFile($folder) {
    $iconFiles = Get-ChildItem -Path $folder -Filter "*.ico" -File

    if ($iconFiles.Count -eq 0) {
        $iconFiles = Get-ChildItem -Path $folder -Filter "*.exe" -File
    }

    if ($iconFiles.Count -gt 0) {
        return $iconFiles[0].FullName
    }

    $subFolders = Get-ChildItem -Path $folder | Where-Object { $_.PSIsContainer }

    foreach ($subFolder in $subFolders) {
        $iconFilePath = FindIconFile($subFolder.FullName)

        if ($null -ne $iconFilePath) {
            return $iconFilePath
        }
    }

    return $null
}


foreach ($file in $appManifests) {
    $gameId = Remove-StringFromLine -FilePath "$($file.FullName)" -TargetString 'appid'
    $gameName = Remove-StringFromLine -FilePath "$($file.FullName)" -TargetString 'name'
    $gameFolderName = Remove-StringFromLine -FilePath "$($file.FullName)" -TargetString 'installdir'

    $gameIconLocation = FindIconFile -folder "$($dir)\common\$($gameFolderName)"
    $shortcut = $shell.CreateShortcut("$desktopPath\$gameName.lnk")
    $shortcut.TargetPath = "C:\Program Files (x86)\Steam\Steam.exe"
    $shortcut.Arguments = "-applaunch $gameId"
    $shortcut.IconLocation = "$($gameIconLocation), 0"
    $shortcut.Save()
}

$shortcut = $shell.CreateShortcut("$desktopPath\Steam.lnk")
$shortcut.TargetPath = "C:\Program Files (x86)\Steam\Steam.exe"
$shortcut.IconLocation = "C:\Program Files (x86)\Steam\Steam.exe, 0"
$shortcut.Save()
