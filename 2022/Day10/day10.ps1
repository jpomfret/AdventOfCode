$instructions = Get-Content .\2022\Day10\input.txt
[array]::Reverse($instructions)

$stackInst = New-Object System.Collections.Generic.Stack[String]

foreach ($ins in $instructions) {
    $stackInst.push($ins)
}

function Test-CycleNum {
    param (
        $cycle
        )
        if ($cycle -eq 20) {
            $true
        } elseif ((($cycle-20) % 40) -eq 0) {
            $true
    } else {
        $false
    }
}

$cpuX = 1
$cycle = 1
$signalStrength = @()

$currentlyProcessing = $false

$pixel = 0
$crt = @()
$line = @()

while($true) {

    if(-not $currentlyProcessing) {
        # pop off the next
        $runInst = $stackInst.pop()
        write-debug 'got new instruction'
    }

    write-debug ('cycle {0} - runinst {1}' -f $cycle, $runinst)

    if (($pixel -ge ($cpuX-1)) -and ($pixel -le ($cpuX+1)) ) {
        #write-verbose 'draw'
        $line += '#'
    } else {
        $line += '.'
    }

    if($line.count -eq 40) {
        #write-verbose '40 pixels - start a new line'
        $crt += @{'row'=$line}
        $line = @()
        $pixel = -1
    }
    $pixel++


    write-debug ('cpuX before - {0}' -f $cpuX)
    if($runInst -eq 'noop') {
        if (Test-CycleNum $cycle) {
            ($cycle * $cpuX)
            $signalStrength += ($cycle * $cpuX)
            write-verbose ('Cycle {0}' -f $cycle)
            write-verbose ('cpuX {0}' -f $cpuX)
        }
    } else {

        if (Test-CycleNum $cycle) {
            ($cycle * $cpuX)
            $signalStrength += ($cycle * $cpuX)
            write-verbose ('Cycle {0}' -f $cycle)
            write-verbose ('cpuX {0}' -f $cpuX)
        }
        if(-not $currentlyProcessing) {
            $currentlyProcessing = $true
            write-debug ('processing...' -f $cycle)
        } else {
            $currentlyProcessing = $false
            $cpuX = $cpuX + $runInst.split(' ')[1]
        }



    }
    $cycle++
    write-debug ('cpuX after - {0}' -f $cpuX)


    if((-not $currentlyProcessing) -and (($stackInst | Measure-Object).Count -eq 0) ) {
        break
    }


}

$signalStrength | Measure-Object -Sum
$crt | select values