# part 1
$ranges = Get-Content .\2022\Day4\input.txt

$count = 0
foreach ($pair in $ranges) {
    $assignments = $pair.split(',')

    # first bottom lower or equal to second bottom
    if(([int]$assignments[0].split('-')[0] -le [int]$assignments[1].split('-')[0]) -and
        # and first top higher than equal to second bottom
        ([int]$assignments[0].split('-')[1] -ge [int]$assignments[1].split('-')[1])) {
            # the second is completely covered
            $count ++
            write-verbose ('{0} fully contains {1}' -f $assignments[0], $assignments[1])
        }
        # second bottom lower or equal to first bottom
        elseif(([int]$assignments[1].split('-')[0] -le [int]$assignments[0].split('-')[0]) -and
        # and second top higher than equal to first bottom
        ([int]$assignments[1].split('-')[1] -ge [int]$assignments[0].split('-')[1])) {
            # the first is completely covered
            $count ++
            write-verbose ('{0} fully contains {1}' -f $assignments[1], $assignments[0])
        }
}

Write-Output ('part 1 : {0}' -f $count)

# part 2

$ranges = Get-Content .\2022\Day4\input.txt

$count = 0
foreach ($pair in $ranges) {
    $assignments = $pair.split(',')

    # first bottom greater or equal to second bottom
    if(([int]$assignments[0].split('-')[0] -ge [int]$assignments[1].split('-')[0]) -and
        # and first bottom lower or equal to second top
        ([int]$assignments[0].split('-')[0] -le [int]$assignments[1].split('-')[1])) {
            # the first is within
            $count ++
            write-verbose ('{0} within {1}' -f $assignments[0], $assignments[1])
        }
        # second bottom greater or equal to first bottom
        elseif(([int]$assignments[1].split('-')[0] -ge [int]$assignments[0].split('-')[0]) -and
        # and second bottom lower or equal to first top
        ([int]$assignments[1].split('-')[0] -le [int]$assignments[0].split('-')[1])) {
            # the first is within
            $count ++
            write-verbose ('{0} within {1}' -f $assignments[0], $assignments[1])
        }
}

Write-Output ('part 2 : {0}' -f $count)
