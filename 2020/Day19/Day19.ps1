#Region Part1
$cubeInput = Get-Content .\sample.txt

# If a cube is active and exactly 2 or 3 of its neighbors are also active, the cube remains active. Otherwise, the cube becomes inactive.
# If a cube is inactive but exactly 3 of its neighbors are active, the cube becomes active. Otherwise, the cube remains inactive.

Function Get-InitialCoords {
    param (
        $input
    )
    $z = 0
    $y = 0
    $x = 0
    foreach ($row in $cubeInput) {

        foreach($c in [char[]]$row) {
            [PSCustomObject]@{
                X = $x
                Y = $y
                Z = 0
                State = $c
            }
            $x++
        }
        $y++
        $x=0
    }
}

Get-CoordNeighbours {
    param (
        $coord,
        $state
    )

    $coord

    $currentX = $coord.X
    $currentY = $coord.Y
    $currentZ = $coord.Z

    $neighbours = @()

    #change just the x's
    $neighbours += $state | Where-Object { $_.X -eq $currentX-1 -and $_.y -eq $currentY -and $_.z -eq $currentZ }
    $neighbours += $state | Where-Object { $_.X -eq $currentX+1 -and $_.y -eq $currentY -and $_.z -eq $currentZ }

    #change just the y's
    $neighbours += $state | Where-Object { $_.X -eq $currentX -and $_.y -eq $currentY+1 -and $_.z -eq $currentZ }
    $neighbours += $state | Where-Object { $_.X -eq $currentX -and $_.y -eq $currentY-1 -and $_.z -eq $currentZ }

    #change just the y's
    $neighbours += $state | Where-Object { $_.X -eq $currentX -and $_.y -eq $currentY -and $_.z -eq $currentZ+1 }
    $neighbours += $state | Where-Object { $_.X -eq $currentX -and $_.y -eq $currentY -and $_.z -eq $currentZ-1 }

    #x - 1
    $neighbours += $state | Where-Object { $_.X -eq $currentX-1 -and $_.y -eq $currentY -and $_.z -eq $currentZ }
    $neighbours += $state | Where-Object { $_.X -eq $currentX-1 -and $_.y -eq $currentY-1 -and $_.z -eq $currentZ }
    $neighbours += $state | Where-Object { $_.X -eq $currentX-1 -and $_.y -eq $currentY-1 -and $_.z -eq $currentZ-1}

    $neighbours += $state | Where-Object { $_.X -eq $currentX-1 -and $_.y -eq $currentY -and $_.z -eq $currentZ }
    $neighbours += $state | Where-Object { $_.X -eq $currentX-1 -and $_.y -eq $currentY-1 -and $_.z -eq $currentZ }
    $neighbours += $state | Where-Object { $_.X -eq $currentX-1 -and $_.y -eq $currentY-1 -and $_.z -eq $currentZ-1}

}

function Invoke-StateChange {
    param (
        $coordinates
    )

    foreach ($coord in $coordinates) {
        $coord
    }


}

$state = Get-InitialCoords -input $cubeInput



#EndRegion


#Region Part2


#EndRegion
