#Region Part1
[bigint[]]$adapters = (Get-Content .\Input.txt)
$adapters = $adapters | Sort-Object

$currentJolts = 0
$diff = @()

foreach ($a in $adapters) {
    $diff += ($a - $currentJolts)
    $currentJolts = $a
}

# my device has +3
$diff += 3

$total = (($diff | Group-Object) | Where Name -eq 1 ).Count * (($diff | Group-Object) | Where Name -eq 3 ).Count
Write-Host ('Part 1: Total of 1 Jolt diffs * 3 Jolt diffs: {0}' -f $total)
#EndRegion


#Region Part2
[bigint[]]$adapters = (Get-Content .\Sample.txt)
$adapters = $adapters | Sort-Object

$currentJolts = 0
$diff = @()

function Get-NextPossibleAdapters {
    param (
        $currentAdapter,
        $adapterList
    )
    $counter = 0
    $maxDiff = 3
    $adapters = $adapterList | Where-Object {$_ -gt $currentAdapter}
    $possibleAdapters = @()

    :whileloop
    while($true) {
        if(($adapters[$counter]-$currentAdapter) -le $maxDiff) {
            $possibleAdapters += $adapters[$counter]
            $counter++
        } else {
            break whileloop
        }
    }
    return $possibleAdapters
}


[array]$combo = 0
$next = Get-NextPossibleAdapters -currentAdapter 0 -adapterList $adapters

$combos = @()
foreach($n in $next) {
    $work = $combo += $n
    $combos += , $work
}
$combos

foreach($n in $next) {
    $workC = ($combo.Clone())
    $workC += $next
    $combos += $workC
}
$combos

foreach($a in $adapters) {
    Get-NextPossibleAdapters -currentAdapter $a -adapterList $adapters
}

$adapters
$counter = 0
$combos = @()
$list = @()
foreach($a in $adapters) {
    $list += $a
}
$combos += $list
#EndRegion
