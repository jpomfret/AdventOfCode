$puzzleInput = Get-Content .\2023\Day7\input.txt

function Get-HandType {
    param (
        $cards
    )

    $rankedCards = [PSCustomObject]@{
        Name = 'A'
        Value = 1
    },[PSCustomObject]@{
        Name = 'K'
        Value = 2
    },[PSCustomObject]@{
        Name = 'Q'
        Value = 3
    },[PSCustomObject]@{
        Name = 'J'
        Value = 4
    },[PSCustomObject]@{
        Name = 'T'
        Value = 5
    },[PSCustomObject]@{
        Name = '9'
        Value = 6
    },[PSCustomObject]@{
        Name = '8'
        Value = 7
    },[PSCustomObject]@{
        Name = '7'
        Value = 8
    },[PSCustomObject]@{
        Name = '6'
        Value = 9
    },[PSCustomObject]@{
        Name = '5'
        Value = 10
    },[PSCustomObject]@{
        Name = '4'
        Value = 11
    },[PSCustomObject]@{
        Name = '3'
        Value = 12
    },[PSCustomObject]@{
        Name = '2'
        Value = 13
    }

    $cardValues = ($cards.toCharArray() | % { ($rankedCards | Where name -eq $_ ) }  )

    $c = $cards.ToCharArray() | Group-Object

    $highestCount = ($c | select -expand Count | sort -desc | select -first 1)
    $secondHighestCount = ($c | select -expand Count | sort -desc | select -first 2)[1]

    if( $highestCount -eq 5) {
        $type = [PSCustomObject]@{
            InitialRank = 1
            Type        = 'five of a kind'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } elseif ($highestCount -eq 4) {
        $type = [PSCustomObject]@{
            InitialRank = 2
            Type        = 'four of a kind'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } elseif ($highestCount -eq 3 -and $secondHighestCount -eq 2) {
        $type = [PSCustomObject]@{
            InitialRank = 3
            Type        = 'Full house'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } elseif ($highestCount -eq 3) {
        $type = [PSCustomObject]@{
            InitialRank = 4
            Type        = 'three of a kind'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } elseif ($highestCount -eq 2 -and $secondHighestCount -eq 2) {
        $type = [PSCustomObject]@{
            InitialRank = 5
            Type        = 'two pairs'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } elseif ($highestCount -eq 2) {
        $type = [PSCustomObject]@{
            InitialRank = 6
            Type        = 'one pair'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } else {
        $type = 'high card'
        $type = [PSCustomObject]@{
            InitialRank = 7
            Type        = 'high card'
            HighCard    = $cardValues
            Cards       = $cards
        }
    }

    return $type
}

function Get-HandTypeWithJokers {
    param (
        $cards
    )

    $rankedCards = [PSCustomObject]@{
        Name = 'A'
        Value = 1
    },[PSCustomObject]@{
        Name = 'K'
        Value = 2
    },[PSCustomObject]@{
        Name = 'Q'
        Value = 3
    },[PSCustomObject]@{
        Name = 'T'
        Value = 5
    },[PSCustomObject]@{
        Name = '9'
        Value = 6
    },[PSCustomObject]@{
        Name = '8'
        Value = 7
    },[PSCustomObject]@{
        Name = '7'
        Value = 8
    },[PSCustomObject]@{
        Name = '6'
        Value = 9
    },[PSCustomObject]@{
        Name = '5'
        Value = 10
    },[PSCustomObject]@{
        Name = '4'
        Value = 11
    },[PSCustomObject]@{
        Name = '3'
        Value = 12
    },[PSCustomObject]@{
        Name = '2'
        Value = 13
    },[PSCustomObject]@{
        Name = 'J'
        Value = 14
    }

    $cardValues = ($cards.toCharArray() | % { ($rankedCards | Where name -eq $_ ) }  )

    $c = $cards.ToCharArray() | Group-Object

    $numOfJokers = ($c | where name -eq 'J' | select -expand Count)

    $highestCount =  0
    if ($numOfJokers -ne 5) {
        $highestCount = ($c | where name -ne 'J' | select -expand Count | sort -desc | select -first 1)
        if($highestCount -ne 5) {
            $secondHighestCount = ($c | where name -ne 'J' | select -expand Count | sort -desc | select -first 2)[1]
        }
    }
    $highestCount = $highestCount + $numOfJokers

    if( $highestCount -eq 5) {
        $type = [PSCustomObject]@{
            InitialRank = 1
            Type        = 'five of a kind'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } elseif ($highestCount -eq 4) {
        $type = [PSCustomObject]@{
            InitialRank = 2
            Type        = 'four of a kind'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } elseif ($highestCount -eq 3 -and $secondHighestCount -eq 2) {
        $type = [PSCustomObject]@{
            InitialRank = 3
            Type        = 'Full house'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } elseif ($highestCount -eq 3) {
        $type = [PSCustomObject]@{
            InitialRank = 4
            Type        = 'three of a kind'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } elseif ($highestCount -eq 2 -and $secondHighestCount -eq 2) {
        $type = [PSCustomObject]@{
            InitialRank = 5
            Type        = 'two pairs'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } elseif ($highestCount -eq 2) {
        $type = [PSCustomObject]@{
            InitialRank = 6
            Type        = 'one pair'
            HighCard    = $cardValues
            Cards       = $cards
        }
    } else {
        $type = 'high card'
        $type = [PSCustomObject]@{
            InitialRank = 7
            Type        = 'high card'
            HighCard    = $cardValues
            Cards       = $cards
        }
    }

    return $type
}

##  part 1 
$outputCards = @()
foreach ($hand in $puzzleInput) {
    $cards = $hand.split(' ')[0]
    $bid = $hand.split(' ')[1]

    $outputCards += Get-HandType -cards $cards | select *, @{l='bid';e={$bid}}

}

$totalWinnings = 0
$rank = 1
$outputCards | Select InitialRank, bid, cards,
    @{l='pos1';e={$_.highcard[0].value}},
    @{l='pos2';e={$_.highcard[1].value}},
    @{l='pos3';e={$_.highcard[2].value}},
    @{l='pos4';e={$_.highcard[3].value}},
    @{l='pos5';e={$_.highcard[4].value}} | Sort-Object initialRank, pos1, pos2, pos3, pos4 ,pos5 -Descending| ForEach-Object -pv output -process { $_ } | ForEach-Object {
        
       $res = $output | select @{l='rank';e={$rank}}, bid, @{l='winnings';e={$rank* $_.bid}}, cards
       #  $output | select * | ft
        
        $totalWinnings += $res.winnings
        $rank++

    }

        write-host ('part 1: {0}' -f $totalWinnings)

##  part 2 
$outputCards = @()
foreach ($hand in $puzzleInput) {
    $cards = $hand.split(' ')[0]
    $bid = $hand.split(' ')[1]

    $outputCards += Get-HandTypeWithJokers -cards $cards | select *, @{l='bid';e={$bid}}

}

$totalWinnings = 0
$rank = 1
$outputCards | Select InitialRank, bid, cards,
    @{l='pos1';e={$_.highcard[0].value}},
    @{l='pos2';e={$_.highcard[1].value}},
    @{l='pos3';e={$_.highcard[2].value}},
    @{l='pos4';e={$_.highcard[3].value}},
    @{l='pos5';e={$_.highcard[4].value}} | Sort-Object initialRank, pos1, pos2, pos3, pos4 ,pos5 -Descending| ForEach-Object -pv output -process { $_ } | ForEach-Object {
        
       $res = $output | select @{l='rank';e={$rank}}, bid, @{l='winnings';e={$rank* $_.bid}}, cards
       #$output | select * | ft
        
        $totalWinnings += $res.winnings
        $rank++

    }

write-host ('part 2: {0}' -f $totalWinnings)


# 254837398