$puzzleInput = Get-Content .\2022\Day6\input.txt

# part 1
$markers = @()
foreach ($row in $puzzleInput) {

    $start = 0
    $end = 3

    while($end -le $row.length) {
        write-debug ($row.ToCharArray()[$start..$end] -join '').ToString()
        $grouped = $row.ToCharArray()[$start..$end] | Group-Object

        if((($grouped | Measure-Object).count) -ne 4) {
            $start++
            $end++
        } else {
            write-verbose 'four uniques!'
            $markers += ($end+1)
            break
        }

    }
}

write-output ('Part 1: {0}' -f $markers)

# part 2
$puzzleInput = Get-Content .\2022\Day6\input.txt

$markers = @()
foreach ($row in $puzzleInput) {

    $start = 0
    $end = 13

    while($end -le $row.length) {
        write-debug ($row.ToCharArray()[$start..$end] -join '').ToString()
        $grouped = $row.ToCharArray()[$start..$end] | Group-Object

        if((($grouped | Measure-Object).count) -ne 14) {
            $start++
            $end++
        } else {
            write-verbose 'fourteen uniques!'
            $markers += ($end+1)
            break
        }

    }
}

write-output ('Part 2: {0}' -f $markers)