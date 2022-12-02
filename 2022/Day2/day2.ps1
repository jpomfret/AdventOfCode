$puzzleInput = Get-Content .\2022\Day2\input.txt


$options = [PSCustomObject]@{
    Name = 'Rock'
    OpLetter = 'A'
    MyLetter = 'X'
    Beats = 'Scissors'
    Score = 1
},[PSCustomObject]@{
    Name = 'Paper'
    OpLetter = 'B'
    MyLetter = 'Y'
    Beats = 'Rock'
    Score = 2
},[PSCustomObject]@{
    Name = 'Scissors'
    OpLetter = 'C'
    MyLetter = 'Z'
    Beats = 'Paper'
    Score = 3
}

# part 1

$totalScore = 0

$puzzleInput | ForEach-Object -PipelineVariable match -Process { $_ } | ForEach-Object {
    $opPlay = $match.Split(' ')[0]
    $myPlay = $match.Split(' ')[1]

    $opDetails = $options | Where-Object OpLetter -eq $opPlay
    $myDetails = $options | Where-Object MyLetter -eq $myPlay

    if( $opDetails.Beats -eq $myDetails.Name ) {
        Write-Verbose 'comp wins'
        $totalScore += 0
    } elseif ($myDetails.Beats -eq $opDetails.Name ) {
        Write-Verbose 'i win'
        $totalScore += 6
    } else {
        Write-Verbose 'draw'
        $totalScore += 3
    }

    # additional points for the hand you played
    $totalScore += $myDetails.score
    #$totalScore
}

Write-Output ('Part 1: {0}' -f $totalScore)

# part 2

$puzzleInput = Get-Content .\2022\Day2\input.txt

$totalScore = 0

$puzzleInput | ForEach-Object -PipelineVariable match -Process { $_ } | ForEach-Object {
    $opPlay = $match.Split(' ')[0]
    $myPlay = $match.Split(' ')[1]

    $opDetails = $options | Where-Object OpLetter -eq $opPlay

    switch ($myPlay) {
        'X' {
            $totalScore += 0
            $totalScore += ($options | Where-Object name -eq $opDetails.Beats).Score
        }
        'Y' {
            $totalScore += 3
            $totalScore += ($options | Where-Object name -eq $opDetails.Name).Score
        }
        'Z' {
            $totalScore += 6
            $totalScore += ($options | Where-Object beats -eq $opDetails.Name).Score
        }
    }

}

Write-Output ('Part 2: {0}' -f $totalScore)
