$raw = Get-Content .\2022\Day5\input.txt -raw
$nl = [System.Environment]::NewLine

$stacks = $raw.split($nl+$nl)[0]
$steps = $raw.split($nl+$nl)[1]

# function to build starting stacks
function Get-StartingStacks {
    param (
        $inputStacks
    )

        $lengths = @()
        foreach ($row in $inputStacks.split($nl)) {
            $lengths += [PSCustomObject] @{
                Length = $row.Length
                Row = ($row.ToCharArray() | Where-Object { $_ -eq '[' } | measure).Count
            }
        }
        $NumberOfStacks = ($lengths | Sort-Object Row -desc | Select-Object -first 1).Row

        $stacksDict = @()
        $sk = 1
        while ( $sk -le $NumberOfStacks ) {
            write-verbose ('make a stack for {0}' -f $sk)

            write-verbose ('build stack {0}' -f $sk)
            $starting = ($sk *3)+(($sk-1))-3
            $ending = $starting + 3

            # $crates = [ordered]@{}
            $crates = New-Object System.Collections.Generic.Stack[String] @()
            foreach ($row in $inputStacks.split($nl)) {
                # don't care about the row with crate numbers
                if($row -match '\[') {
                    $ct = ($row.ToCharArray()[$starting..$ending]) -join ''
                    if($ct -match '\[') {
                        #$crates.add($orderedCrate,($row.ToCharArray()[$starting..$ending]) -join '')
                        $crates.push($ct)
                    }
                }
            }


            $stacksDict += New-Variable -Name ('Stack{0}' -f $sk) -PassThru -Value ([System.Collections.Stack]::new(@($crates)))
            $sk++

        }
        $stacksDict
    }

function Invoke-CrateMove9000 {
param (
    $currentStacks,
    $from,
    $to
    )

    # pop off a crate
    $crateToMove = ($currentStacks | Where-Object name -eq ('stack{0}' -f $from)).value.pop()

    ($currentStacks | Where-Object name -eq ('stack{0}' -f $to)).value.push($crateToMove)

    #$currentStacks
}

function Invoke-CrateMove9001 {
    param (
        $currentStacks,
        $from,
        $to,
        $numberToMove
        )

        $counter = 1
        $StageCrates = New-Object System.Collections.Generic.Stack[String] @()
        while ($counter -le $numberToMove) {
            # pop off a crate
            $crateToMove = ($currentStacks | Where-Object name -eq ('stack{0}' -f $from)).value.pop()

            #stage it
            $StageCrates.push($crateToMove)

            $counter++
        }

        $counter = 1
        while ($counter -le $numberToMove) {
            # pop off the stage
            $crateToMove = $StageCrates.pop()

            #add to final
            ($currentStacks | Where-Object name -eq ('stack{0}' -f $to)).value.push($crateToMove)
            $counter++

        }

        #$currentStacks
    }

function Get-FinalString {
    param (
        $topCrates
    )
    ($topCrates).replace('[','').replace(']','').trim() -join ''
}


#region part 1!

# change stacks into stacks
$crateStacks = Get-StartingStacks $stacks

foreach ($step in ($steps.split($nl))) {

    Write-verbose ('step string: {0}' -f $step)

    $numOfCrates, $fromStack, $toStack = ($step | select-string -pattern '(\d+)' -AllMatches | Select-Object -expand matches).Value

    $counter = 1
    while ($counter -le $numOfCrates) {
        write-verbose ('moving a crate from {0}-->{1}' -f $fromStack, $toStack)
        Invoke-CrateMove9000 -currentStacks $crateStacks -From $fromStack -To $toStack
        $counter++
    }

    Write-verbose ('post process: {0} from {1}-->{2}' -f $numOfCrates, $fromStack, $toStack)

}

$finalTop = @()
foreach($c in $crateStacks) {
    $finalTop += $c.value[0].peek()
}

Write-Output ('Part 1: {0}' -f (Get-FinalString  $finalTop))
#endregion


#region part 2

# change stacks into stacks
$crateStacks = Get-StartingStacks $stacks

foreach ($step in ($steps.split($nl))) {

    Write-verbose ('step string: {0}' -f $step)

    $numOfCrates, $fromStack, $toStack = ($step | select-string -pattern '(\d+)' -AllMatches | Select-Object -expand matches).Value

    Invoke-CrateMove9001 -currentStacks $crateStacks -From $fromStack -To $toStack -numberToMove $numOfCrates

    Write-verbose ('post process: {0} from {1}-->{2}' -f $numOfCrates, $fromStack, $toStack)

}

$finalTop = @()
foreach($c in $crateStacks) {
    $finalTop += $c.value[0].peek()
}

Write-Output ('Part 2: {0}' -f (Get-FinalString  $finalTop))

#endregion
