$wordSearch = Get-Content .\2024\Day4\input.txt



# find coordinates of X - this will be starting points
function Get-XCoords {
    param (
        $wordSearch,
        $letter = 'X'
    )
    $xCoords = @()
    $x = 0
    $y = 0
    foreach($row in $wordSearch) {
        Write-Debug ('x={0},y={1}' -f $x, $y)
        Write-Debug ('row: {0}' -f $row)
            
        foreach($char in $row.ToCharArray()){
            Write-Debug ('x={0},y={1}' -f $x, $y)
            Write-Debug ('char: {0}' -f $char)
            if($char -eq $letter) {
                Write-Verbose ('{0} marks the spot! {1},{2}' -f $letter, $x, $y)
                $xCoords += [PSCustomObject]@{
                    x = $x
                    y = $y
                }
            }

            $x++
        }
        $x=0
        $y++
    }
    $xCoords
}

<#
direction codes from X
.123.
.4X5.
.678.
#>

function Test-XCoord {
    param (
        $wordSearch,
        $Coord,
        $letter = 'X'
    )
    Write-Debug ('Testing the {0} at ({1},{2})' -f $letter, $Coord.x, $Coord.y)

    $nextLetter = switch ($letter) {
        'X' {'M'}
        'M' {'A'}
        'A' {'S'}
    }

    $coordsNextLetter = @()

    # if it next to it on the left
    if($Coord.X -ne 0) {
        if ($wordSearch[$Coord.Y][$Coord.X-1] -eq $nextLetter) {
            if(-not($Coord.DirectionCode) -or $coord.DirectionCode -eq 4) {
                $nextCoord = [PSCustomObject]@{
                    X = $Coord.X-1
                    Y = $Coord.Y
                    Letter = $nextLetter
                    DirectionCode = 4
                }
                $coordsNextLetter += $nextCoord
            }
        }
    }

    # if it is next to it on the right
    if($Coord.X -le $wordSearch[$Coord.Y].Length-2) {
        if ($wordSearch[$Coord.Y][$Coord.X+1] -eq $nextLetter) {
            if(-not($Coord.DirectionCode) -or $coord.DirectionCode -eq 5) {
                $nextCoord = [PSCustomObject]@{
                    X = $Coord.X+1
                    Y = $Coord.Y
                    Letter = $nextLetter
                    DirectionCode = 5
                }
                $coordsNextLetter += $nextCoord
            }
        }
    }
    # if it is below
    if($Coord.Y -le $wordSearch.Length-2) {
        if ($wordSearch[$Coord.Y+1][$Coord.X] -eq $nextLetter) {
            if(-not($Coord.DirectionCode) -or $coord.DirectionCode -eq 7) {
                $nextCoord = [PSCustomObject]@{
                    X = $Coord.X
                    Y = $Coord.Y+1
                    Letter = $nextLetter
                    DirectionCode = 7
                }
                $coordsNextLetter += $nextCoord
            }
        }
    }
    # if it is above
    if($Coord.Y -ne 0) {
        if ($wordSearch[$Coord.Y-1][$Coord.X] -eq $nextLetter) {
            if(-not($Coord.DirectionCode) -or $coord.DirectionCode -eq 2) {
                $nextCoord = [PSCustomObject]@{
                    X = $Coord.X
                    Y = $Coord.Y-1
                    Letter = $nextLetter
                    DirectionCode = 2
                }
                $coordsNextLetter += $nextCoord
            }
        }
    }

    # diagonals
    if($Coord.Y -ne 0 -and $Coord.X -ne 0 ) {
        if ($wordSearch[$Coord.Y-1][$Coord.X-1] -eq $nextLetter) {
            if(-not($Coord.DirectionCode) -or $coord.DirectionCode -eq 1) {
                $nextCoord = [PSCustomObject]@{
                    X = $Coord.X-1
                    Y = $Coord.Y-1
                    Letter = $nextLetter
                    DirectionCode = 1
                }
                $coordsNextLetter += $nextCoord
            }
        }
    }
    if($Coord.Y -ne 0 -and $Coord.X -le $wordSearch[$Coord.Y].Length-2) {
        if ($wordSearch[$Coord.Y-1][$Coord.X+1] -eq $nextLetter) {
            if(-not($Coord.DirectionCode) -or $coord.DirectionCode -eq 3) {
                $nextCoord = [PSCustomObject]@{
                    X = $Coord.X+1
                    Y = $Coord.Y-1
                    Letter = $nextLetter
                    DirectionCode = 3
                }
                $coordsNextLetter += $nextCoord
            }
        }
    }
    if($Coord.Y -le $wordSearch.Length-2 -and $Coord.X -le $wordSearch[$Coord.Y].Length-2) {
        if ($wordSearch[$Coord.Y+1][$Coord.X+1] -eq $nextLetter) {
            if(-not($Coord.DirectionCode) -or $coord.DirectionCode -eq 8) {
                $nextCoord = [PSCustomObject]@{
                    X = $Coord.X+1
                    Y = $Coord.Y+1
                    Letter = $nextLetter
                    DirectionCode = 8
                }
                $coordsNextLetter += $nextCoord
            }
        }
    }
    if($Coord.Y -le $wordSearch.Length-2 -and $Coord.X -ne 0) {
        if ($wordSearch[$Coord.Y+1][$Coord.X-1] -eq $nextLetter) {
            if(-not($Coord.DirectionCode) -or $coord.DirectionCode -eq 6) {
                $nextCoord = [PSCustomObject]@{
                    X = $Coord.X-1
                    Y = $Coord.Y+1
                    Letter = $nextLetter
                    DirectionCode = 6
                }
                $coordsNextLetter += $nextCoord
            }
        }
    }
    
    $coordsNextLetter
}

#region part 1 
$xCoords = Get-XCoords -wordSearch $wordSearch

#DEBUG: Testing the A at (4,9)
# $testCoord.X = 1
# $testCoord.Y = 3
# $testCoord.DirectionCode = 2
# Test-XCoord -Coord $testCoord -wordSearch $wordSearch -letter M 

$count = 0
foreach ($xCoord in $xCoords) {
    Write-Verbose ('working on finding M - ({0},{1})' -f $xCoord.X, $xCoord.Y)
    $mCoords = Test-XCoord -Coord $xCoord -wordSearch $wordSearch -letter X
    #$mCoords

    foreach ($mCoord in $mCoords) {
        Write-Verbose ('working on finding A - ({0},{1})' -f $mCoord.X, $mCoord.Y)
        $aCoords = Test-XCoord -Coord $mCoord -wordSearch $wordSearch -letter M
        #$aCoords
        
        foreach ($aCoord in $aCoords) {
            Write-Verbose ('working on finding S - ({0},{1})' -f $mCoord.X, $mCoord.Y)
            $sCoords = Test-XCoord -Coord $aCoord -wordSearch $wordSearch -letter A
            #$sCoords

            $count = $count + $sCoords.Count
        }
    }
}
write-host ('part 1: {0}' -f $count)
#endregion

#region part 2
function Test-Corners {
    param (
        $wordSearch,
        $Coord
    )
    Write-Debug ('Testing the {0} at ({1},{2})' -f 'A', $Coord.x, $Coord.y)
    
    # diagonals
    if($Coord.Y -ne 0 -and $Coord.X -ne 0 ) {
        $directionCode1 = $wordSearch[$Coord.Y-1][$Coord.X-1]
    }
    if($Coord.Y -ne 0 -and $Coord.X -le $wordSearch[$Coord.Y].Length-2) {
        $directionCode3 = $wordSearch[$Coord.Y-1][$Coord.X+1]
    }
    if($Coord.Y -le $wordSearch.Length-2 -and $Coord.X -le $wordSearch[$Coord.Y].Length-2) {
        $directionCode8 = $wordSearch[$Coord.Y+1][$Coord.X+1]
    }
    if($Coord.Y -le $wordSearch.Length-2 -and $Coord.X -ne 0) {
        $directionCode6 = $wordSearch[$Coord.Y+1][$Coord.X-1]
    }

    if(($directionCode6 -eq 'M' -and $directionCode3 -eq 'S') -or ($directionCode6 -eq 'S' -and $directionCode3 -eq 'M')) {
        if(($directionCode1 -eq 'M' -and $directionCode8 -eq 'S') -or ($directionCode1 -eq 'S' -and $directionCode8 -eq 'M')) {
            $true
        }
    }

    Remove-Variable directionCode1, directionCode3, directionCode6, directionCode8 -ErrorAction SilentlyContinue
}

$aCoords = Get-XCoords -wordSearch $wordSearch -letter A

$count = 0 
$aCoords.foreach{
    if(Test-Corners -wordSearch $wordSearch -Coord $_) {
        $count++
    }
} 
write-host ('part 2: {0}' -f $count)
#endregion
