$puzzleInput = Get-Content .\2023\Day9\input.txt

function get-diff {
    param (
        [int[]]$values
    )   

    $returnValues = @()
    for ($i = 0; $i -lt ($values.Length-1); $i++) {
        write-verbose ('{0} - {1}' -f $values[($i+1)], $values[$i])
        $returnValues += $values[($i+1)] - $values[$i]
    }

    return $returnValues
}

#region part 1 
[int]$sumOfLastValues = 0 
foreach ($dataset in $puzzleInput) {
    $values = $dataset.split(' ')

    # create the array to work with 
    $AllValues = @()
    while ($true) {

        $allValues += [PSCustomObject]@{
            Values = $values
        }

        $newValues = Get-Diff -values $values 
        if( ($newValues | Group | Measure Count).Count -eq 1) {
            write-verbose ('we are done - they all match - {0}' -f ($newValues -join ','))
            $allValues += [PSCustomObject]@{
                Values = $newValues
            }
            break
        }
        $values = $newValues
    }

    for ($j = 0; $j -lt ($AllValues.count); $j++) {
        #$j
        
       if($j -eq 0) {
           [int]$numToAdd = $allvalues[-1].Values[0]
       } else {
           $workingOn = $allValues[-($j+1)].Values 
           write-verbose ('working on row: {0} - {1}' -f $j, ($workingOn -Join ' ' )) 
           [int]$lastValue = [int]$workingOn[-1] + [int]$numToAdd
           write-verbose ('last Value: {0} + {1} = {2}' -f $workingOn[-1], $numToAdd, $lastValue) 
           $allValues[-($j+1)].Values += $lastvalue

           [int]$numToAdd = [int]$lastValue
       }
    }

    # we care about this value
    write-verbose ('the final value is: {0}' -f $allValues[0].Values[-1])
    $sumOfLastValues += [int]$allValues[0].Values[-1]

}
#endregion
Write-Host ('Part 1: {0}' -f $sumOfLastValues)

#region part 2
[int]$sumOfFirstValues = 0 
foreach ($dataset in $puzzleInput) {
    [int[]]$values = $dataset.split(' ')

    # create the array to work with 
    $AllValues = @()
    while ($true) {

        $allValues += [PSCustomObject]@{
            Values = $values
        }

        $newValues = Get-Diff -values $values 
        if( ($newValues | Group | Measure Count).Count -eq 1) {
            write-verbose ('we are done - they all match - {0}' -f ($newValues -join ','))
            $allValues += [PSCustomObject]@{
                Values = $newValues
            }
            break
        }
        $values = $newValues
    }

    for ($j = 0; $j -lt ($AllValues.count); $j++) {
        #$j
        
       if($j -eq 0) {
           [int]$numToSubtract = $allvalues[-1].Values[0]
       } else {
           $workingOn = $allValues[-($j+1)].Values 
           write-verbose ('working on row: {0} - {1}' -f $j, ($workingOn -Join ' ' )) 
           [int]$firstValue = [int]$workingOn[0] - [int]$numToSubtract
           write-verbose ('last Value: {0} - {1} = {2}' -f $workingOn[0], $numToSubtract, $firstValue)        
           $allValues[-($j+1)].Values = ,[int]$firstValue + $allValues[-($j+1)].Values
           
           write-verbose ('now the row is: {0} - {1}' -f $j, ($allValues[-($j+1)].Values -Join ' ')) 
           [int]$numToSubtract = [int]$firstValue
       }
    }

    # we care about this value
    write-verbose ('the first value is: {0}' -f $allValues[0].Values[0])
    $sumOfFirstValues += $allValues[0].Values[0]

}
#endregion
Write-Host ('Part 2: {0}' -f $sumOfFirstValues)