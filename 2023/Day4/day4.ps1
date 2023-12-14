$puzzleInput = Get-Content .\Day4\input.txt

$totalPoints = 0
$cards = @()
foreach ($card in $puzzleInput) {
    #$card
    $cardNumber = $card.split(':')[0].trim().split(' ')[1]
    $cardValues = $card.split(':')[1]
    $winningNumbers = $cardValues.Split('|')[0].trim().Split(' ') | Where-Object { $_ -ne $null -and $_ -ne ''}
    $ourNumbers = $cardValues.Split('|')[1].trim().Split(' ') | Where-Object { $_ -ne $null -and $_ -ne ''}

    $countWins = 0
    foreach ($num in $ourNumbers) {
        if($num -in $winningNumbers) {
            $countWins++
        }
    }

    $cards += [PSCustomObject]@{
        CardNumber = [int]$cardNumber
        Wins = [int]$countWins
    }

    # calculate using geometric sequence
    # ar(n-1)
    if ($countWins -gt 0) {
        $a = 1 # the first term
        $r = 2 # ratio
        $points = [math]::pow(($a*$r), ($countWins-1))
        $totalPoints += $points
        Write-Verbose ('{0} winning numbers = points {1}' -f $countWins, $points)
        
    }

}

Write-Host ('Part 1 - {0}' -f $totalPoints)

$totalPart2 = 0
# foreach ($card in $cards) {
#     if($card.wins -gt 0) {
#         $cards += $cards | Where-Object {$_.CardNumber -gt $card.CardNumber -and $_.CardNumber -lt ($card.CardNumber + $card.wins)}
#     }
# }

# $cards | ForEach-Object { $totalpart2 += $_.Wins}

$i = 0
while ($true) { 
    if($cards[$i].wins -gt 0) {

        $toAdd = $cards |
        Where-Object {$_.CardNumber -gt $cards[$i].CardNumber -and $_.CardNumber -le ($cards[$i].CardNumber + $cards[$i].wins)} | 
        Select-Object -Unique CardNumber, Wins

        $cards += $toAdd
    }
    if ($i -eq $cards.length) {
        break
    }
    $i++
} 

# 1 for the first match, then doubled three times for each of the three matches after the first
Write-Host ('Part 2 - {0}' -f $cards.Count)
