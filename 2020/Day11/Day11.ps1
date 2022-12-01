#Region Part1
function Test-AdjacentSeats {
    Param(
        $seatingPlan,
        $x,
        $y
    )
    $width = $seatingPlan[0].Length-1
    $height = $seatingPlan.count-1

    #Write-Host ('current seat ({0},{1})' -f $x, $y)

    $adjSeats = @()

    #don't do if we're going negative
    if($x-1 -ge 0) {
        $adjSeats += $seatingPlan[$x-1][$y]
        if($y+1 -le $height) {
            $adjSeats += $seatingPlan[$x-1][$y+1]
        }
    }
    if($y-1 -ge 0) {
        $adjSeats += $seatingPlan[$x][$y-1]
        if($x+1 -lt $width) {
            $adjSeats += $seatingPlan[$x+1][$y-1]
        }
    }
    if(($x-1 -ge 0) -and ($y-1 -ge 0)) {
        $adjSeats += $seatingPlan[$x-1][$y-1]
    }
    if($x+1 -lt $width) {
        $adjSeats += $seatingPlan[$x+1][$y]
    }
    if($y+1 -le $height) {
        $adjSeats += $seatingPlan[$x][$y+1]
    }
    if($y+1 -le $height -and $x+1 -lt $width) {
        $adjSeats += $seatingPlan[$x+1][$y+1]
    }
    return $adjSeats | Group-Object
}

Copy-Item sample.txt Work.txt

$counter = 0
while ($true) {
    $rawSeatingPlan = (Get-Content .\Work.txt)

    $seatingPlan = @()
    $rawSeatingPlan.ForEach{
        $row = @()
        $psitem.foreach{
            $row += [char[]]$psitem
        }
        $seatingPlan += , $row
    }
    # can't just clone a nested array
    $sp = @()
    $rawSeatingPlan.ForEach{
        $row = @()
        $psitem.foreach{
            $row += [char[]]$psitem
        }
        $sp += , $row
    }

    $x = 0
    $y = 0
    $changes = $false # while this keep looping
    foreach($row in $sp){
        foreach ($chair in [char[]]$row) {
            Write-Host ('working on ({0},{1} - {2})' -f $x, $y, $chair)
            if($chair -ne '.') {
                try {
                    $adjChr = Test-AdjacentSeats -seatingPlan $seatingPlan -x $x -y $y
                    $adjChr
                    if($chair -eq 'L' -and ($adjChr | Where Name -eq '#').Count -eq 0) {
                        $sp[$x][$y] = '#'
                        $changes = $true
                    } elseif ($chair -eq '#' -and ($adjChr | Where Name -eq '#').Count -ge 4) {
                        $sp[$x][$y] = 'L'
                        $changes = $true
                    }
                } catch {
                    $error[0] | fl * -Force
                    break
                }
            }
            $y++
        }
        $y=0
        $x++
    }

    $output = @()
    foreach($r in $sp) {
        $output += ($r -join '')
    }
    Set-content -Path .\Work.txt -Value $output

    if (!$changes) {
        break whileloop
    }
    $counter++

}

$final = get-content work.txt
$total = 0
foreach ($r in $final) {
    $total = $total + ([char[]]$r | where {$_ -eq '#'} | Measure).Count
}

Write-Host ('Part 1: Taken seats: {0}' -f $total)
#EndRegion


#Region Part2
#EndRegion
