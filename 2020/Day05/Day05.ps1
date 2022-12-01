$boardingPasses = Get-Content .\input.txt

#Region Part1
$bpNum = @()
foreach($bp in $boardingPasses) {
    $rowLower = 0
    $rowHigher = 127
    $rowRange = 128

    $colLower = 0
    $colHigher = 7
    $colRange = 8
    foreach($c in [char[]]$bp) {

        switch ($c) {
            # rows
            'F' { $rowRange = $rowRange / 2; $rowHigher = $rowHigher - $rowRange;  }
            'B' { $rowRange = $rowRange / 2; $rowLower = $rowLower + $rowRange;  }
            # cols
            'R' { $colRange = $colRange / 2; $colLower = $colLower + $colRange;  }
            'L' { $colRange = $colRange / 2; $colHigher = $colHigher - $colRange;  }
        }
    }
    $bpNum += ($rowHigher * 8) + $colHigher
}

Write-Host ('Part 1: Maximum BP is {0}' -f $($bpNum | Measure-Object -Maximum).Maximum)
#EndRegion

#Region Part2
$bpOrdered = ($bpNum | sort-object)
$bpprevious = $bpOrdered[0]
$bpOrdered.Foreach{
    $current = $psitem
    if($current -ne ($bpprevious  + 1)) {
        $myseat = $current - 1
        if(($myseat -1) -in $bpOrdered -and ($myseat + 1) -in $bpOrdered) {
            Write-Host ('Part 2: {0} is my seat' -f $myseat)
        }
    }
    $bpprevious = $current
}
#EndRegion

