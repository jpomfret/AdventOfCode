$puzzle = (get-content ./2024/Day1/input.txt).split('`n')


$list1=@()
$list2=@()

foreach($line in $puzzle) {
    $list1+=$line.split('   ')[0].trim()
    $list2+=$line.split('   ')[1].trim()
}

$listSorted1 = $list1 | sort
$listSorted2 = $list2 | sort

$diff = 0
for ($i = 0; $i -lt $listSorted1.Length; $i++) {
    <# Action that will repeat until the condition is met #>
    $d = [Math]::Abs(($listSorted1[$i] - $listSorted2[$i]))
    Write-Host ('we have {0} - {1} = {2}' -f $listSorted1[$i],$listSorted2[$i],$d)

    $diff = $diff + $d
}
Write-host ('part 1 is {0}' -f $diff)

#part2
$sim = 0
foreach($num in $list1){
    [int]$num
    [int]$c = ($list2 | where {$_ -eq $num} | measure).count
    $s = [int]$num * [int]$c
    Write-Host('num is {0}, it appears {1} so the score is {1}' -f $num, $c, $sim)
    $sim = $sim + $s
}
$sim