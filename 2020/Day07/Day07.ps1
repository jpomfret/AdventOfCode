# import the data
$luggageRules = Get-Content .\input.txt

#Region Part1
# parse the rules into an object
$rules = @()
foreach ($lrule in $luggageRules) {
    $pattern = "(\w+ \w+)(?=\s+bag)"
    $results = $lrule | Select-String $pattern -AllMatches

    $rules += [PSCustomObject]@{
        Outer = $results.Matches.Value[0]
        Inner = $results.Matches.Value[1..($results.Matches.Length)]
    }
}

$total = @()
$myBag = 'shiny gold'

# Initial bags
$bags = $rules | Where-Object Inner -contains $myBag
$total += $bags

# loop through bags that can contain bag
while ($bags) {
    $work = $bags.clone()

    $bags = @()
    $work.Outer | ForEach-Object -PipelineVariable outer -Process {$_} | ForEach-Object {
        $bags +=  $rules | Where-Object Inner -contains $outer
        $total += $bags
    }

}

Write-Host ('Part 1: {0} can contain the shiny gold bag' -f ($total | select -Unique outer | measure).Count)
#EndRegion

#Region Part2
# import the data
$luggageRules = Get-Content .\input.txt

#Region Part1
# parse the rules into an object
$rules = @()
foreach ($lrule in $luggageRules) {
    $outerPattern = "(\w+ \w+)(?=\s+bag)"
    $innerPattern = "(\w+ \w+ \w+)(?=\s+bag)"
    $outerResults = $lrule | Select-String $outerPattern -AllMatches
    $innerResults = $lrule | Select-String $innerPattern -AllMatches

    if($innerResults.Matches.Value -eq 'contain no other') {
        $rules += [PSCustomObject]@{
            Outer = $outerResults.Matches.Value[0]
            InnerNum = $innerResults.Matches.Value
            TotalBagsIn = 0
            InnerNoNum = $innerResults.Matches.Value.Foreach{$psitem.Split(' ',2)[1]}
        }
    } else {
        $rules += [PSCustomObject]@{
            Outer = $outerResults.Matches.Value[0]
            InnerNum = $innerResults.Matches.Value
            TotalBagsIn = ($innerResults.Matches.Value.Foreach{$psitem.Split(' ',2)[0]} | Measure -Sum).Sum
            InnerNoNum = $innerResults.Matches.Value.Foreach{$psitem.Split(' ',2)[1]}
        }
    }
}

$totalPartTwo = @()
$myBag = 'Shiny Gold'
[Array]$containsBags = $rules | Where-Object outer -eq $mybag
#$totalPartTwo += $containsBags
$bagCount = 0

# loop through bags that can contain bag
:whileloop
while ($true) {
    $work = $containsBags.clone()
    $totalPartTwoBefore = $totalPartTwo.Clone()

    $containsBags = @()
    $work.InnerNum | ForEach-Object -PipelineVariable inner -Process {$_} | ForEach-Object {
        if($inner -ne 'contain no other') {
            $num, $bagtype = $inner.split(' ',2)
            $i = 1
            for($i; $i -le $num;$i++) {
                if($rules | Where-Object Outer -contains $bagtype) {
                    $containsBags += $rules | Where-Object Outer -contains $bagtype
                    $totalPartTwo += $rules | Where-Object Outer -contains $bagtype
                }

            }
        }
    }

    if(!(compare-object $totalPartTwo $totalPartTwoBefore)) {
        break whileloop
    }
}

Write-Host ('Part 2: The shiny gold bag will contain {0}' -f $totalPartTwo.count)
#EndRegion