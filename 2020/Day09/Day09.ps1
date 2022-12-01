#Region Part1
function Get-FirstInvalidNumber {
    param (
        $preambleLength = 25,
        $xmasData = (Get-Content .\Sample.txt)
    )
    $current = 0
    :whileloop
    while ($true) {
        $test = $false
        $testNumber = $xmasData[($preambleLength+$current)]

        :outerforeach
        foreach ($numOne in $xmasData[$current..($current+($preambleLength-1))]) {
            foreach ($numTwo in $xmasData[$current..($current+($preambleLength-1))]) {
                if($numOne -ne $numTwo) {
                    $sum = [int]$numOne + [int]$numTwo
                    #write-host ("{0} + {1} = {2}" -f $numOne, $numTwo, $sum)
                    if ($sum -eq $testNumber) {
                        $current++
                        $test = $true
                        break outerforeach
                    }
                }
            }
        }
        if (!$test) {
            return $testNumber
        }
    }
}
#EndRegion
$testNumber = Get-FirstInvalidNumber -preambleLength 25 -xmasData (Get-Content .\Input.txt)
Write-Host ('Part 1: First non valid number is {0}' -f $testNumber)

#Region Part2

$xmasData =  (Get-Content .\Input.txt)
$firstInvalid = Get-FirstInvalidNumber -preambleLength 25 -xmasData $xmasData

$counter = 0
$start = 0

:foreachloop
foreach($num in $xmasData) {
    $numbersUsed = @()

    $sum = 0
    $counter = $start
    :whileloop
    while ($true) {
        $numbersUsed += $xmasData[$counter]
        $sum = $sum + $xmasData[$counter]
        if($sum -eq $firstInvalid) {
            $weakness = [int]($numbersUsed | sort)[0] + [int]($numbersUsed | sort)[-1]
            write-host ("Part 2: Encryption Weakness is {0}" -f $weakness)
            break foreach
        }
        elseif($sum -gt $firstInvalid) {
            $start++
            break whileloop
        }
        $counter++
    }
}
#EndRegion
