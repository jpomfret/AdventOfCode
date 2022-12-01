#Region Part1
function Invoke-MemoryGame {
    param (
        [int[]]$StartingNumbers,
        $FinalPosition = 2020
    )

    $workNumbers = @()

    $turn = 1
    $workNumbers = foreach($num in $StartingNumbers) {
        [PSCustomObject]@{
            Num = $num
            Position = $turn
        }
        $turn++
    }

    :whileloop
    while ($true) {
        $turnNumber = $workNumbers[$turn-2]
        Write-Debug ('number if {0}' -f $turnNumber.Num)

        if(($workNumbers | Where-Object Num -eq $turnNumber.Num | Measure-Object).Count -gt 1) {
            # already been mentioned get places
            $positions = $workNumbers | Where-Object Num -eq $turnNumber.Num | Sort-Object Position -Desc

            $workNumbers += [PSCustomObject]@{
                Num = $positions[0].Position - $positions[1].Position
                Position = $turn
            }
        } else {
            # first mention - add zero
            $workNumbers += [PSCustomObject]@{
                Num = 0
                Position = $turn
            }
        }
        # break out when we have the 2020'th number
        if($turn -eq $FinalPosition) {
            break whileloop
        } else {
            $turn++
        }
    }
    return $workNumbers | Where-Object Position -eq $FinalPosition
}

# Final Answer - Commented out to not mess with pester test importing functions
#Invoke-MemoryGame -StartingNumbers 19,20,14,0,9,1 -FinalPosition 2020

#EndRegion


#Region Part2


#EndRegion
