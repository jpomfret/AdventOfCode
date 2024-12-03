param (
    $year,
    $day
)

$FolderName = ('{0}\{1}\Day{2}' -f $PSScriptRoot, $year, $day)
Write-Output ('create folder: {0}' -f $FolderName)

New-Item -Path $FolderName -ItemType Directory
New-Item -ItemType File -Path ('{0}\day{1}.ps1' -f $folderName, $day)
New-Item -ItemType File -Path ('{0}\inputsample.txt' -f $folderName)
New-Item -ItemType File -Path ('{0}\input.txt' -f  $folderName)
