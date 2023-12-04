# any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum.
$puzzleInput = Get-Content .\Day3\sample.txt

$y = 0

foreach ($line in $puzzleInput) {
    $x = 0 
    $line

    $num = 664

    foreach ($letter in $line.ToCharArray()) {
        $letter
        if(($line[0..$line.length] -join '') -like ('{0}*' -f $num)) {
            'found it'
        }
        $x++
    }

    $y++
}

