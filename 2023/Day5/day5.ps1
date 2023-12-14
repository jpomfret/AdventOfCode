$puzzleInput = Get-Content .\Day5\input.txt

$seeds = $puzzleInput[0].Replace('seeds: ','').Split(' ')


function Lookup_map {
    param (
        $map,
        [bigint]$inputValue
    )

    write-debug ('InputValue is: {0}' -f $inputValue)

    $mapped = $false
    foreach($line in $map) {
        $values = $line.split(' ')

        [bigint]$destination = $values[0]
        [bigint]$source = $values[1]
        [bigint]$range = $values[2]
        [bigint]$diff = $destination - $source

        write-debug ('range is {0} - {1}' -f $source, ($source+$range))
        if($inputValue -ge $source -and $inputValue -lt ($source+$range)) {
            $output = $inputValue + $diff
            $mapped = $true
        }
    }
    if (-not $mapped) {
        $output = $inputValue
    }
    write-debug ('output is: {0}' -f $output)
    return $output
}

# create the maps
$variablesToClear = @()
foreach ($line in $puzzleInput) {
    # skip the seed line
    if ($line -notlike 'seeds:*') {
        if ($line -match '[a-z]') {
            # its a heading
            ('{0} - is a heading' -f $line)
            $mapName = $line.Replace(' map:','').replace('-','_')
            New-Variable -Name $mapName
            $values = @()
            $variablesToClear += $mapName
        } elseif ($line -match '[0-9]') {
            ('{0} - are numbers' -f $line)
            $values += $line            
        } else {
            ('{0} - is empty' -f $line)
            if ($mapName) {
                $values
                $mapname
                Set-Variable -Name $mapName -Value $values
            }
        }
    }
    if ($line -eq $puzzleInput[-1]) {
        Set-Variable -Name $mapName -Value $values
    }
}
# Remove-Variable $variablesToClear
# remove-variable mapname

function Invoke-Mapper {
    param (
        $seed
    )

    write-verbose ('looking up seed: {0}' -f $seed)
    
    # map to soil
    $soil = Lookup_map -map $seed_to_soil -inputValue $seed
    write-verbose ('soil: {0}' -f $soil)
    
    # map soil to fertilizer
    $fertilizer = Lookup_map -map $soil_to_fertilizer -inputValue $soil
    write-verbose ('fertilizer: {0}' -f $fertilizer)
    
    # map fertilizer to water
    $water = Lookup_map -map $fertilizer_to_water -inputValue $fertilizer
    write-verbose ('water: {0}' -f $water)
    
    # map water to light
    $light = Lookup_map -map $water_to_light -inputValue $water
    write-verbose ('light: {0}' -f $light)
    
    # map light to temp
    $temp = Lookup_map -map $light_to_temperature -inputValue $light
    write-verbose ('temp: {0}' -f $temp)
    
    # map temp to humidity
    $hum = Lookup_map -map $temperature_to_humidity -inputValue $temp
    write-verbose ('hum: {0}' -f $hum)
    
    # map humidity to location
    $loc = Lookup_map -map $humidity_to_location -inputValue $hum
    write-verbose ('loc: {0}' -f $loc)

    return $loc
}

## part 1

$locations = @()
foreach ($seed in $seeds) {
    write-verbose ('looking up seed: {0}' -f $seed)
    
    [bigint]$loc = Invoke-Mapper $seed

    $locations += $loc

}
write-host ('part 1: {0}' -f ($locations | sort | select -first 1))

## part 2
# seeds are ranges


$seedPosition = 0
$allTheSeeds = @()
foreach ($s in $seeds) {
    
    if($seedPosition % 2 -eq 0) {
        Write-Verbose ('{0} is even so start of seeds' -f $seedPosition)
        [bigint]$startSeed = $s
    }
    if($seedPosition % 2 -ne 0) {
        Write-Verbose ('{0} is odd so its a range value' -f $seedPosition)
        [bigint]$endSeed = ($startSeed + $s -1)

        write-host ('range is {0}-{1}' -f $startSeed, $endSeed)
        $allTheSeeds += ('{0}-{1}' -f $startSeed, $endSeed)
    }
    
    $seedPosition++
}

$locations = @()
foreach ($r in $allTheSeeds) {
    [int]$firstSeed = $r.Split('-')[0]
    [int]$lastSeed = $r.Split('-')[1]
    # map
    
    for($i = $firstSeed; $i -le $lastSeed; $i++) {
        write-verbose ('run it for {0}' -f $i)
        [int]$loc = Invoke-Mapper $i
        
        $locations += $loc
        write-verbose ('{0} outputs {1}' -f $i, $loc)
    }
}

write-host ('part 2: {0}' -f ($locations | sort | select -first 1))
