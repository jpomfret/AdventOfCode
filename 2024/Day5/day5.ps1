$rules = (Get-Content .\2024\Day5\inputsample.txt) | where { $_ -like '*|*' }
$manuals = (Get-Content .\2024\Day5\inputsample.txt) | where { $_ -like '*,*' }

$passedManuals = @()
$incorrectManuals = @()

foreach ($man in $manuals) {
    $pass = $true
    foreach ($r in $rules) {

        Write-Debug ('working on {0}' -f $r)

        $pos = 0
        $ruleCheck = @()
        foreach ($page in $man.split(',')) {
            if ($page -in $r.split('|')) {
                write-debug ('found {0} at position {1}' -f $page, $pos)
                $ruleCheck += [PSCustomObject]@{
                    page     = $page
                    rule     = $r
                    rulePos  = if ($page -eq $r.split('|')[0]) { 0 } else { 1 } # was it first or second in the rule
                    position = $pos
                }
            }
            $pos++
        }
    
        if ($ruleCheck.count -eq 2) {
            if (($ruleCheck | Sort-Object position)[0].rulePos -lt ($ruleCheck | Sort-Object position)[1].rulePos) {
                Write-Debug ('{0} - passed the rule {1}' -f $man, $r)
            }
            else {
                Write-Debug ('{0} - failed the rule {1}' -f $man, $r)
                $pass = $false
            }
        }   
        else {
            write-debug ('skipping rule {0}' -f $r)
        }
    }
    if ($pass) {
        $passedManuals += $man
    }
    else {
        $incorrectManuals += $man
    }
}
Write-Host('Count of manuals passed = {0}' -f $passedManuals.Count)

$total = 0
foreach ($p in $passedManuals) {
    $total += $p.split(',')[[int]($p.Split(',').count - 1) / 2]
}
Write-Host('Total of middle pages = {0}' -f $total)

#part 2
$incorrectManuals