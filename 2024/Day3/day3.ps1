$memory = Get-Content .\2024\Day3\input.txt

# part 1
$instructions = ($memory | select-string -Pattern 'mul\(\d{1,3},\d{1,3}\)' -AllMatches | Select-Object -Expand matches).Value

$total = 0
$instructions.foreach{
    $n = $_.Replace('mul(','').Replace(')','').Split(',')
    $mul = [int]$n[0]*[int]$n[1]
    $total += $mul
    Write-Verbose ('{0} * {1} = {2}. Total now {3}' -f $n[0], $n[1], $mul, $total)

}

Write-Host ('Part 1: {0}' -f $total)

# part 2
$instructions = ($memory | select-string -Pattern "mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)" -AllMatches | Select-Object -Expand matches).Value

$total2 = 0
$enabled = $true
$instructions.foreach{
    $inst = $_
    if ($inst -like 'mul*' -and $enabled) {   
        $n = $_.Replace('mul(','').Replace(')','').Split(',')
        $mul = [int]$n[0]*[int]$n[1]
        $total2 += $mul
        Write-Verbose ('{0} * {1} = {2}. Total now {3}' -f $n[0], $n[1], $mul, $total2)
    } elseif ($inst -eq 'do()') {
        $enabled = $true
    } elseif ($inst -eq "don't()") {
        $enabled = $false
    }
}
Write-Host ('Part 2: {0}' -f $total2)
