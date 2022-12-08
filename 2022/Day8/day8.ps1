$treegrid = Get-Content .\2022\Day8\input.txt


Function Get-TreeMap {
    param (
        $treeGrid
    )

    $trees = @()

    $rowCounter = 0
    foreach ($row in $treegrid) {
        write-verbose ('Row {0}' -f $rowCounter)

        $colCounter = 0
        foreach ($col in $row.ToCharArray()) {
            write-verbose ('Row:Col {0}:{1}' -f $rowCounter, $colCounter)

            $trees += [PSCustomObject] @{
                Row = $rowCounter
                Col = $colCounter
                Height = $col
            }

            $colCounter++
        }

        $rowCounter++
    }

    $trees

}


$trees = Get-Treemap $treegrid

# edges can all be seen
$maxRow = ($trees | Sort-Object row -desc | Select-Object -first 1 row).Row
$maxCol = ($trees | Sort-Object col -desc | Select-Object -first 1 col).Col

$outerTrees = $trees | where-object {$_.row -in (0, $maxRow) -or $_.col -in (0, $maxcol) }
$innerTrees = $trees | where-object {$_.row -notin (0, $maxRow) -and $_.col -notin (0, $maxcol) }

$totalEdge = $outerTrees| Measure-Object


## inner trees need checking

$visibleCount = 0

foreach ($t in $innerTrees) {

    write-verbose ('checking tree {0},{1}' -f $t.row, $t.col)

    if(-not($trees | Where-Object {$_.row -lt $t.row -and $_.col -eq $t.col -and $_.Height -ge $t.Height}) ) {
        write-verbose 'visible from the north'
        $visibleCount++
    } elseif(-not ($trees | Where-Object {$_.row -gt $t.row -and $_.col -eq $t.col -and $_.Height -ge $t.Height}) ) {
        write-verbose 'visible from the south'
        $visibleCount++
    } elseif(-not ($trees | Where-Object {$_.row -eq $t.row -and $_.col -gt $t.col -and $_.Height -ge $t.Height}) ) {
        write-verbose 'visible from the east'
        $visibleCount++
    } elseif(-not ($trees | Where-Object {$_.row -eq $t.row -and $_.col -lt $t.col -and $_.Height -ge $t.Height}) ) {
        write-verbose 'visible from the west'
        $visibleCount++
    }

}

Write-host ('Part 1: {0}' -f ([int]$visibleCount + [int]$totalEdge.Count))

# part 2

$scenicScores = @()
foreach ($t in $innerTrees) {
    write-output ('checking tree {0},{1}' -f $t.row, $t.col)

    ## look to the north
    $scenicNorth = 0
    $rowCheck = ($t.Row-1)

    :scenicNCheck
    while ($rowCheck -ge 0) {

        $treeToSee = ($trees | Where-Object {$_.row -eq $rowCheck -and $_.col -eq $t.col})
        $scenicNorth++

        if($treeToSee.Height -ge $t.Height ) {
            # can't see past this
            break scenicNCheck
        }

        $rowCheck--
    }

    ## look to the south
    $scenicSouth = 0

    $rowCheck = ($t.Row+1)
    :scenicSCheck
    while ($rowCheck -le $maxRow) {

        $treeToSee = ($trees | Where-Object {$_.row -eq $rowCheck -and $_.col -eq $t.col})
        $scenicSouth++

        if($treeToSee.Height -ge $t.Height ) {
            # can't see past this
            break scenicSCheck
        }

        $rowCheck++
    }

    ## look to the east
    $scenicEast = 0

    $colCheck = ($t.Col+1)
    :scenicECheck
    while ($colCheck -le $maxCol) {

        $treeToSee = ($trees | Where-Object {$_.row -eq $t.Row -and $_.col -eq $colCheck})
        $scenicEast++

        if($treeToSee.Height -ge $t.Height ) {
            # can't see past this
            break scenicECheck
        }

        $colCheck++
    }


    ## look to the west
    $scenicWest = 0

    $colCheck = ($t.Col-1)
    :scenicWCheck
    while ($colCheck -ge 0) {

        $treeToSee = ($trees | Where-Object {$_.row -eq $t.Row -and $_.col -eq $colCheck})
        $scenicWest++

        if($treeToSee.Height -ge $t.Height ) {
            # can't see past this
            break scenicWCheck
        }

        $colCheck--
    }

    write-verbose ('scenicNorth: {0}' -f $scenicNorth)
    write-verbose ('scenicSouth: {0}' -f $scenicSouth)
    write-verbose ('scenicEast: {0}' -f $scenicEast)
    write-verbose ('scenicWest: {0}' -f $scenicWest)

    $scenicScores += $scenicNorth * $scenicSouth * $scenicEast * $scenicWest
}

Write-host ('Part 2: {0}' -f ($scenicScores | Sort-Object -Descending | Select-Object -first 1))