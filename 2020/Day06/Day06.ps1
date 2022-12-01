# import the data
$nl = [System.Environment]::NewLine
$customForms = Get-Content .\input.txt -Delimiter $nl$nl

#Region Part1
$total = 0
foreach ($form in $customForms) {
    $total += ([char[]]$form | Where-Object { $_ -match '\S' } | Select-Object -Unique $_ | Measure-Object).Count
}
Write-Host ('Part 1: Sum of the custom answers is {0}' -f $total)
#EndRegion

#Region Part2
$total = 0
foreach ($form in $customForms) {
    $peopleInGroup = ($form.split($nl) | Where-Object { $_ -match '\S' } | Measure-Object).Count
    $total += ([char[]]$form  | Where-Object { $_ -match '\S' }  | Group-Object | Where-Object count -eq $peopleInGroup | Measure-Object).Count
}
Write-Host ('Part 2: Sum of the custom answers is {0}' -f $total)
#EndRegion