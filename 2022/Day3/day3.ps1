$puzzleInput = Get-Content .\2022\Day3\input.txt

function get-priority {
    param (
        $letter
    )


    $counter = 1
    # 1 - 26 for lowercase
    ('a'..'z').ForEach{
         if($letter -ceq $_) {
            $totalPriority += $counter
            Write-Verbose "Found $_"
            $counter
        }
        $counter++
    }
    # 27 - 52 for uppercase
    ('A'..'Z').ForEach{
        if($letter -ceq $_) {
            $totalPriority += $counter
            Write-Verbose "Found $_"
            $counter
        }
        $counter++
   }
}

$totalPriority = 0
$puzzleInput | ForEach-Object -PipelineVariable rucksack -Process { $_ } | ForEach-Object {
    $firstPocket = $rucksack[0..(($rucksack.Length/2)-1)]
    $secondPocket = $rucksack[(($rucksack.Length/2))..($rucksack.Length)]

    $inBoth = (Compare-Object $firstPocket $secondPocket -IncludeEqual -ExcludeDifferent -CaseSensitive -PassThru)

    $totalPriority += (get-priority $inBoth)

}
Write-Output ('Part 1 - {0}' -f $totalPriority)

# part 2

$puzzleInput = Get-Content .\2022\Day3\input.txt

$totalPriority = 0

$group = @()
$badgePriority = 0
$puzzleInput | ForEach-Object -PipelineVariable rucksack -Process { $_ } | ForEach-Object {

    $group += $rucksack

    if ($group.count -eq 3) {
        # compare
        foreach ($letter in $group[0].ToCharArray()) {
            if(($group[1].ToCharArray() -ccontains $letter) -and ($group[2].ToCharArray() -ccontains $letter)) {
                Write-Verbose ('badge letter is {0}' -f $letter) # badge letter!
                $badgePriority += (get-priority $letter)

                # empty the group
                $group = @()
                break
            }
        }

    }
}

Write-Output ('Part 2 - {0}' -f $badgePriority)