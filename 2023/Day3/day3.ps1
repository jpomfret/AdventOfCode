# any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum.
$global:gears = @()
$global:tempgears = @()

function check-around {
    param (
        $puzzleInput,
        $x,
        $y
    )
    $touchingPattern = $false

    $maxX = $puzzleInput[0].Length -1 
    $maxY = $puzzleInput.Length -1 

    # top row
    if ($x -gt 0 -and $y -gt 0 -and $puzzleInput[$x-1][$y-1] -match '[^A-z.0-9]') {
        $touchingPattern = $true
        if ($puzzleInput[$x-1][$y-1] -eq '*') {
            'its a gear - count it!'
            $global:tempgears += ('gear_{0}_{1}' -f ($x-1), ($y-1))
        }
    }

    if ($y -gt 0 -and $puzzleInput[$x][$y-1] -match '[^A-z.0-9]') {
        $touchingPattern = $true
        if ($puzzleInput[$x][$y-1] -eq '*') {
            'its a gear - count it!'
            $global:tempgears += ('gear_{0}_{1}' -f $x, ($y-1))
        }
    }
    if ($y -gt 0 -and $x -lt $maxX -and $puzzleInput[$x+1][$y-1] -match '[^A-z.0-9]') {
        $touchingPattern = $true
        if ($puzzleInput[$x+1][$y-1] -eq '*') {
            'its a gear - count it!'
            $global:tempgears += ('gear_{0}_{1}' -f ($x+1), ($y-1))
        }
    }

    #middle row
    if ($x -gt 0 -and $puzzleInput[$x-1][$y] -match '[^A-z.0-9]') {
        $touchingPattern = $true
        if ($puzzleInput[$x-1][$y] -eq '*') {
            'its a gear - count it!'
            $global:tempgears += ('gear_{0}_{1}' -f ($x-1), $y)
        }
    }
    if ($x -lt $maxX -and $puzzleInput[$x+1][$y] -match '[^A-z.0-9]') {
        $touchingPattern = $true
        if ($puzzleInput[$x+1][$y] -eq '*') {
            'its a gear - count it!'
            $global:tempgears += ('gear_{0}_{1}' -f ($x+1), $y)
        }
    }

    # bottom row

    if ($x -gt 0 -and $y -lt $maxY -and $puzzleInput[$x-1][$y+1] -match '[^A-z.0-9]') {
        $touchingPattern = $true
        if ($puzzleInput[$x-1][$y+1] -eq '*') {
            'its a gear - count it!'
            $global:tempgears += ('gear_{0}_{1}' -f ($x-1), ($y+1))
        }
    }
    if ($y -lt $maxY -and $puzzleInput[$x][$y+1] -match '[^A-z.0-9]') {
        $touchingPattern = $true
        if ($puzzleInput[$x][$y+1] -eq '*') {
            'its a gear - count it!'
            $global:tempgears += ('gear_{0}_{1}' -f $x, ($y+1))
        }
    }
    if ($x -lt $maxX -and $y -lt $maxY -and $puzzleInput[$x+1][$y+1] -match '[^A-z.0-9]') {
        $touchingPattern = $true
        if ($puzzleInput[$x+1][$y+1] -eq '*') {
            'its a gear - count it!'
            $global:tempgears += ('gear_{0}_{1}' -f ($x+1), ($y+1))
        }
    }

    return $touchingPattern
}

$puzzleInput = Get-Content .\Day3\input.txt

$x = 0
$allNumbers = @()

foreach ($line in $puzzleInput) {
    $y = 0 

    $num = @()
    $symbolTest = $false

    foreach ($char in $line.ToCharArray()) {

        if($char -match '[0-9]') {
            write-verbose ('{0} - is a number!' -f $char)
            write-verbose ('{0},{1} - are the coords!' -f $x,$y)
            
            $num += $char
            # test if we touch a symbol
            if(check-around -puzzleInput $puzzleInput -x $x -y $y ) {
                write-verbose 'it is by a symbol'
                $symbolTest = $true
            }


            # if the next one is not a number
            if ($line.ToCharArray()[$y+1] -notmatch '[0-9]') {
                # end of a number 
                if ($symbolTest) {
                    $allNumbers += ($num -join '')
                }

                # aggregate gear data
                $global:gears += ($global:tempgears | Select-Object -Unique @{l='gear';e={$_}}, @{l='number';e={($num -join '')}})
                $global:tempgears = @()

                #reset num
                $num = @()
                $symbolTest = $false
            }
            
        }
        
        $y++
    }
    $x++
}

$total = 0
$allNumbers | Foreach-Object { $total = $total + $_ }
('Part 1: {0}' -f $total)

$finalGears = $gears | Group-Object -Property gear | Where-Object {$_.group.count -eq 2 } 

$TotalRatios = 0
$finalGears | ForEach-Object {
    $ratio = 1
    $_.Group.Number | ForEach-Object {
        $ratio *= $_
    }
    $TotalRatios += $ratio
}

('Part 2: {0}' -f $TotalRatios)