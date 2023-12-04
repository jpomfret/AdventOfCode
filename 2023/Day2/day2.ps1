$puzzleInput = get-content .\day2\input.txt


function Test-LowerThanCubeMax {
    param (
        $cubeColour,
        [int]$number
    ) 
        
    $max = @{
        #12 red cubes, 13 green cubes, and 14 blue cubes
        'red'   = 12
        'green' = 13
        'blue'  = 14
    }
    write-verbose ('Testing "{0}" with "{1}"' -f $cubeColour, $number)

    if ($number -gt $max.$cubeColour) {
        $false
    } else {
        $true
    }

}

$results = 0
$totalPowersPart2 = 0

foreach ($game in $puzzleInput) { 
    $gameNumber = $game.split(':')[0].Split(' ')[-1]
    $draws = $game.split(':')[-1].Split(';')
    
    $works = $true

    $maxCubesNeeded = @{
        'red'   = 0
        'green' = 0
        'blue'  = 0
    }

    foreach ($d in $draws) {
        $d.split(',').trim().foreach{
            $cubeColour = $_.split(' ')[-1]
            [int]$number = $_.split(' ')[0].trim()

            ## part 1 see if the game is valid
            write-verbose ('Part 1 - Testing {0} with {1} cubes' -f $cubeColour, $number)
            if(Test-LowerThanCubeMax -cubeColour $cubeColour -number $number) {
                write-debug 'good'
            } else {
                $works = $false
            }
            
            ## part 2 see what the max cubes we need are
            write-verbose ('Part 2 - Recording max values for {0}' -f $cubeColour)
            write-verbose ('Part 2 - Max value for {0} is currently {1} and we have {2}' -f $cubeColour, $maxCubesNeeded.$cubeColour, $number)

            if ($number -gt $maxCubesNeeded.$cubeColour) {
                $maxCubesNeeded.$cubeColour = $number
            }
        }
    }
    if ($works) {
        Write-host ('game {0} works' -f $gameNumber)
        $results = $results + $gameNumber.trim()
    }
    $i = 1
    $maxCubesNeeded.values | % { $i *= $_}
    write-output ('The power of game {0} if {1}' -f $gameNumber, $i)
    $totalPowersPart2 += $i
}

write-host ('part 1: {0}' -f $results)
write-host ('part 2: {0}' -f $totalPowersPart2)


## part 2 
