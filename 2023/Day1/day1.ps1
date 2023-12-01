$inputPath = '.\Day1\input.txt'
$puzzleInput = (Get-Content $inputPath)

$calibrationTotal = 0
foreach($line in $puzzleInput) {
    $digits = ''
    foreach($value in $line.ToCharArray()) {
        if ($value -match '[0-9]') {
            $digits += $value
        }
    }

    write-verbose ('digits is is {0}' -f $digits)
    $total = ('{0}{1}' -f $digits[0], $digits[-1])
    write-verbose ('line total is is {0}' -f $total)
    $calibrationTotal += [int]$total
}
write-output ('Part 1: Calibration output is {0}' -f $calibrationTotal)

$spelledOutNumbers = @{
    'One' = 1
    'Two' = 2
    'Three' = 3
    'Four' = 4
    'Five' = 5
    'Six' = 6
    'Seven' = 7
    'Eight' = 8
    'Nine' = 9
}

$calibrationTotal2 = 0
foreach($line in $puzzleInput) {
    Write-Debug $line
    $digits = ''
    $placeInLine = 0
    foreach($value in $line.ToCharArray()) {
        ## for each spelled out number see if it matches at the start of the line from this position
        $spelledOutNumbers.keys | ForEach-Object { 
            if( $line[$placeInLine..$line.length] -join '' -like ('{0}*' -f $_)) { 
                $value = $spelledOutNumbers.$_ 
            }
        }
        if ($value -match '[0-9]') {
            $digits += $value
        }
        $placeInLine ++
    }

    write-verbose ('digits is {0}' -f $digits)
    $total = ('{0}{1}' -f $digits[0], $digits[-1])
    write-verbose ('line total is {0}' -f $total)
    $calibrationTotal2 += [int]$total
    write-verbose ('calibration output is {0}' -f $2)
}

write-output ('Part 2: Calibration output is {0}' -f $calibrationTotal2)

