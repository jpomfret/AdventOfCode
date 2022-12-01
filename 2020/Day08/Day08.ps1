function Invoke-BootCode {
    param (
        $instructions
    )
    $accumulator = 0
    $nextPosition = 0
    $position = @()
    #Region Part1
    while($true) {
        if($position -contains $nextPosition -or $nextPosition -gt ($instructions.Length-1)) {
            break
        } else {
            $position += $nextPosition
        }

        $instType, $instAmt = $instructions[$nextPosition].split(' ')
        $instDir = $instAmt[0]
        $instNum = $instAmt.Substring(1)

        if($instType -eq 'acc') {
            if($instDir -eq '+') {
                $accumulator = $accumulator + $instNum
            } else {
                $accumulator = $accumulator - $instNum
            }
            $nextPosition++
        } elseif ($instType -eq 'jmp') {
            if($instDir -eq '+') {
                $nextPosition = $nextPosition + $instNum
            } else {
                $nextPosition = $nextPosition - $instNum
            }
        } elseif ($instType -eq 'nop') {
            $nextPosition++
        }
    }
    [PSCustomObject]@{
        Accumulator = $accumulator
        Position = $position
    }
}
$results = Invoke-BootCode -instructions (Get-Content .\Input.txt)
Write-Host ('Part 1: Accumulator is {0} before the first duplicate' -f $results.accumulator)
#EndRegion

#Region Part2
$instructions = Get-Content .\input.txt
$editPosition = -1
$currentPosition = 0

:whileloop
while ($true) {
    $results = Invoke-BootCode -instructions $instructions
    $currentPosition = 0
    if ($results.Position -contains ($instructions.Length-1)) {
        $results.Accumulator
        break whileloop
    } else {
        # alter the code
        :foreachloop
        foreach ($inst in $instructions) {
            $instType, $instAmt = $inst.split(' ')
            if ($instType -in ('nop','jmp') -and $currentPosition -gt $editPosition) {
                $editPosition = $currentPosition
                $instructions = Get-Content .\input.txt
                # swap the command
                if($instType -eq 'nop') {
                    $instructions[$currentPosition] = ("jmp {0}" -f $instAmt)
                    break foreachloop
                } else {
                    $instructions[$currentPosition] = ("nop {0}" -f $instAmt)
                    break foreachloop
                }
            }
            $currentPosition++
        }
    }
}
Write-Host ('Part 1: Accumulator is {0} at successful completion' -f $results.accumulator)
#EndRegion
