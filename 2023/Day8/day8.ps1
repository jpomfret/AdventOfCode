$puzzleInput = Get-Content -Path .\2023\Day8\input.txt

$rightLeftInstructions = $puzzleInput[0]*100000
#$rightLeftInstructions = $puzzleInput[0]

$map = $puzzleInput[2..($puzzleInput.Length)]

$mapObject = @()
foreach ($row in $map) {
    $mapObject += [PSCustomObject]@{
        Start = $row.split('=')[0].Trim()
        Left  = $row.split('=')[1].Trim().Split(',')[0].Replace('(','').Trim()
        Right = $row.split('=')[1].Trim().Split(',')[1].Replace(')','').Trim()
    }
}

## part 1 
$completed = $false
$currentSpot = 'AAA'
$countInstr = 0
foreach ($instruction in $rightLeftInstructions.ToCharArray()) {
    #$instruction
    $countInstr++
    if ($instruction -eq 'L') {
        $currentSpot = $mapObject | Where-Object start -eq $currentSpot | Select-Object -Expand Left
    } else {
        $currentSpot = $mapObject | Where-Object start -eq $currentSpot | Select-Object -Expand Right
    }
    Write-Verbose ('Inst: {0} - current is now {1}' -f $instruction, $currentSpot)

    if ($currentSpot -eq 'ZZZ') {
        write-host ('part 1: got it in {0}' -f $countInstr)
        $completed = $true
        break
    }
}
if(-not $completed) {
    write-host ('uh oh we did not find ZZZ - need more instructions')
}

## part 2 

# get all the spots starting with A
$currentSpots = $mapObject | Where-Object Start -like '*A' | Select -expand Start
$completed = $false
$countInstr = 0
foreach ($instruction in $rightLeftInstructions.ToCharArray()) {
    #$instruction
    $countInstr++
    if ($instruction -eq 'L') {
        $currentSpots = $currentSpots | Foreach-Object { $mapObject | Where-Object start -eq $PSItem | Select-Object -Expand Left } 
    } else {
        $currentSpots = $currentSpots | Foreach-Object { $mapObject | Where-Object start -eq $PSItem | Select-Object -Expand Right } 
    }
    Write-Verbose ('Inst: {0} - current is now {1}' -f $instruction, ($currentSpots -join ','))

    if ( ($currentSpots | Foreach-Object { $PSItem -like '*Z' }) -notcontains $false ) {
        write-host ('part 2: got it in {0}' -f $countInstr)
        $completed = $true
        break
    }
}
if(-not $completed) {
    write-host ('uh oh we did not find ZZZ - need more instructions')
}