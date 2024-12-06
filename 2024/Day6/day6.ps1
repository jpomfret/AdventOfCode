

<#
If there is something directly in front of you, turn right 90 degrees.
Otherwise, take a step forward.
#>

$map = Get-Content .\2024\Day6\input.txt


function find-thing {
    param(
        $thing,
        $map
    )

    write-debug ('looking for {0}' -f $thing)
    
    $guardShape = '<','>','^','v'
    $x = 0
    $y = 0
    
    foreach($line in $map) {
        foreach ($space in $line.ToCharArray()){
            if($thing -eq 'guard' -and $space -in $guardShape) {
                write-debug ('found the guard - ({0},{1})' -f $x, $y)
                [PSCustomObject]@{
                    Thing = $thing
                    Direction = $space
                    X = $x
                    Y = $y
                    GuardPositions = ('({0},{1})' -f $x, $y)
                }
            }
            $x++
        }
        $y++
        $x=0
    }
}

function move-guard {
    param (
        $map#,
        #$guardCoords
    )
    write-debug ('guard currently at ({0},{1})' -f $guardCoords.X, $guardCoords.Y)

    # copy to a new array so we don't change the original
    $testCoord = [PSCustomObject]@{
        Thing = $guardCoords.Thing
        Direction = $guardCoords.Direction
        X = $guardCoords.X
        Y = $guardCoords.Y
        Count = $guardCoords.Count
    }

    $yMax = $map.Count-1
    $xMax = $map[0].Length-1
    switch($guardCoords.Direction) {
        '>' {if($testCoord.X -eq $xMax ) { throw 'off the map'} else {$testCoord.X = $testCoord.X+1} }
        '<' {if($testCoord.X -eq 0 ) { throw 'off the map'} else {$testCoord.X = $testCoord.X-1} }
        '^' {if($testCoord.X -eq 0 ) { throw 'off the map'} else {$testCoord.Y = $testCoord.Y-1} }
        'v' {if($testCoord.Y -eq $yMax ) { throw 'off the map'} else {$testCoord.Y = $testCoord.Y+1 } }
    }

    #check there is nothing in the way 
    if($map[$testCoord.Y][$testCoord.X] -ne '#') {
        $guardCoords.X = $testCoord.X
        $guardCoords.Y = $testCoord.Y
        $guardCoords.GuardPositions += (';({0},{1})' -f $testCoord.X, $testCoord.Y)
    } else {
        Write-warning ('uh-oh.. bumped into something')
        $guardCoords.Direction = switch ($guardCoords.Direction) {
            '>' {'v'}
            '<' {'^'}
            '^' {'>'}
            'v' {'<'}    
        }
    }
    $guardCoords
}


$global:guardCoords = find-thing -thing 'guard' -map $map

while($true) {
    try { 
        $null = move-guard -map $map #-guardCoords $guardCoords
    } catch { 
        break
    }
}

$spots = $guardCoords.GuardPositions.split(';')
($spots | select -Unique | measure).count

write-host ('part 1: {0}' -f ($spots | select -Unique | measure).count)