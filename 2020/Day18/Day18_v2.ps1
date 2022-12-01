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
            Position = {$turn}.Invoke()  # https://www.jonathanmedd.net/2014/01/adding-and-removing-items-from-a-powershell-array.html
        }
        $turn++
    }

    $turnNumber = $workNumbers[$turn-2].Num

    :whileloop
    while ($true) {
        Write-Debug ('number if {0}' -f $turnNumber)

        if((($workNumbers | Where-Object Num -eq $turnNumber).Position | Measure-Object).Count -gt 1) {
            # already been mentioned add places
            $positions = $workNumbers | Where-Object Num -eq $turnNumber | Select -Expand Position |  Sort-Object @{e={$_ -as [int]}} -Desc
            Sort-Object
            $num = $positions[0] - $positions[1]
            if($workNumbers | where Num -eq $num) {
                ($workNumbers | where Num -eq $num).Position.Add($turn)
            } else {
                $workNumbers += [PSCustomObject]@{
                    Num = $num
                    Position = {$turn}.Invoke()  # https://www.jonathanmedd.net/2014/01/adding-and-removing-items-from-a-powershell-array.html
                }
            }
            $turnNumber = $num
        } else {
            # first mention - add zero
            if($workNumbers | where Num -eq 0) {
                ($workNumbers | where Num -eq 0).Position.Add($turn)
            } else {
                $workNumbers += [PSCustomObject]@{
                    Num = 0
                    Position = {$turn}.Invoke()  # https://www.jonathanmedd.net/2014/01/adding-and-removing-items-from-a-powershell-array.html
                }
            }
            $turnNumber = 0
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

#Invoke-MemoryGame -StartingNumbers 0,3,6 -FinalPosition 2020

# Final Answer - Commented out to not mess with pester test importing functions
#Invoke-MemoryGame -StartingNumbers 19,20,14,0,9,1 -FinalPosition 2020

#EndRegion


#Region Part2


#EndRegion
