$puzzleInput = Get-Content -Path ./Day6/input.txt

function Get-MaxDistance { 
    param (
    
    [bigint]$buttonHoldMS,
    [bigint]$totalRaceTimeMS
    )

    $speed = $buttonHoldMS

    write-verbose ('The boat will travel at {0} mm\ms' -f $speed)

    $distance = ($totalRaceTimeMS - $buttonHoldMS) * $speed

    write-verbose ('DISTANCE: {0}' -f $distance)
    return $distance

}

function Get-Results {
    param (
       [bigint[]]$times,
       [bigint[]]$distances 
    )
    $results = 1
    
    for ($i=0; $i -lt $times.length; $i++) {
        #for ($i=0; $i -lt 1; $i++) {
        [bigint]$raceTime = $times[$i]
        [bigint]$raceDistance = $distances[$i]

        Write-Verbose ('Race {0} - time {1} - max distance {2}' -f $i, $raceTime, $raceDistance)
        
        $options = 0
        for ($s=0; $s -le $raceTime; $s++) {
            write-verbose ('Race {0} - test holding button for {1}' -f $i, $s )
            if((Get-MaxDistance -buttonHoldMS $s -totalRaceTimeMS $raceTime) -gt $raceDistance) {
                $options++
            }
        }
        $results = $results * $options 
        
    }
    $results
}
        

# part 1
$times = $puzzleInput[0].replace('Time:','').split(' ').trim() | Where-Object { $_ -ne '' }
$distances = $puzzleInput[1].replace('Distance:','').split(' ').trim() | Where-Object { $_ -ne '' } 

Get-Results -times $times -distances $distances

# starting speed of zero millimeters per millisecond. 
# For each whole millisecond you spend at the beginning of the race holding down the button, the boat's speed increases by one millimeter per millisecond

# part 2 
$times = ($puzzleInput[0].replace('Time:','').split(' ').trim() | Where-Object { $_ -ne '' }) -join ''
$distances = ($puzzleInput[1].replace('Distance:','').split(' ').trim() | Where-Object { $_ -ne '' }) -join ''

Get-Results -times $times -distances $distances
