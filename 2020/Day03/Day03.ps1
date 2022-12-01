$map = Get-Content .\input.txt

function Get-TreeCollisions {
    param(
        $Slope
    )
    $x = 0
    $y = 0
    $rowCounter = 0
    $trees = 0
    foreach ($row in $map) {
        if ($rowCounter -eq $y) {
            # should be able to work out how many times the row needs to be repeated
            #$row = $row * (($map.Length * $slope['X'] * $slope['Y']) / $row.Length)
            $row = $row * 100
            if ($row[$x] -eq '#') {
                $trees++
            }
            $x = $x + $slope['X']
            $y = $y + $slope['Y']
        }
        $rowCounter++
    }
    $trees
}

$part1 = Get-TreeCollisions -Slope @{
    X = '3'
    Y = '1'
}
Write-Host ('Part 1: {0} trees were hit' -f $part1)
#EndRegion

#Region Part 2
$slopes = @{
    X = '1'
    Y = '1'
},
@{
    X = '3'
    Y = '1'
},
@{
    X = '5'
    Y = '1'
},
@{
    X = '7'
    Y = '1'
},
@{
    X = '1'
    Y = '2'
}

$sum = 1
$trees = foreach ($slope in $slopes) {
    $sum = $sum * (Get-TreeCollisions -Slope $slope)
}
Write-Host ('Part 2: {0} trees were hit' -f $sum)
#EndRegion