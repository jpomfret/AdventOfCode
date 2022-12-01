# Part 1

$nl = [System.Environment]::NewLine
$calories = Get-Content 2022\day1\input.txt -raw

$elfTotals = @()

$calories.split($nl+$nl) | foreach-object -PipelineVariable elfCals -Process { $_ } | ForEach-Object {
    $elfTotals += ($elfCals.Split($nl) | Measure-Object -Sum).Sum
}

$elfTotals | Sort-Object -Descending | Select-Object -first 1

# Part 2

($elfTotals | Sort-Object -Descending | Select-Object -first 3 | Measure-Object -Sum).Sum
