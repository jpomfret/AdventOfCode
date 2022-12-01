$passwords = Get-Content .\Input.txt


#Region Part 1
$valid = 0
$passwords | ForEach-Object -PipelineVariable pwd -Process {$_} | ForEach-Object {
    $bits = $pwd.Split(' ')
    $ruleNum = $bits[0]
    $ruleLet = $bits[1].Replace(':','')
    $password = $bits[2]

    $count = 0
    [char[]]$password | ForEach-Object -PipelineVariable lt -Process {$_} | ForEach-Object {
        if($lt -eq $ruleLet) {
            $count++
        }
    }
    $boundaries = $ruleNum.Split('-')
    if($count -ge $boundaries[0] -and $count -le $boundaries[1]){
        $valid++
    }
}
Write-Host ('Part 1: {0} passwords are valid' -f $valid)
#EndRegion

#Region Part 2
$valid = 0
$passwords | ForEach-Object -PipelineVariable pwd -Process {$_} | ForEach-Object {
    $bits = $pwd.Split(' ')
    $ruleNum = $bits[0]
    $ruleLet = $bits[1].Replace(':','')
    $password = $bits[2]

    $places = $ruleNum.Split('-') # ruleLet should exist in these places
    if(([char[]]$password[[int]$places[0]-1] -eq $ruleLet) -xor ([char[]]$password[[int]$places[1]-1]) -eq $ruleLet){
        $valid++
    }
}
Write-Host ('Part 2: {0} passwords are valid' -f $valid)
#EndRegion