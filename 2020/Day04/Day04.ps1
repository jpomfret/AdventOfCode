$nl = [System.Environment]::NewLine
$passports = Get-Content .\input.txt -Delimiter $nl$nl

#Region Part1
$requiredFields = 'byr','iyr','eyr','hgt','hcl','ecl','pid'#,'cid'
$validCount = 0
foreach ($ppt in $passports) {
    $fields = @()
    $bits = $ppt.split(' ').split($nl)
    $bits.Where{$_}.Foreach{
        $fields += $psitem.split(':')[0]
    }
    $compare = Compare-Object $fields $requiredFields
    if (!($compare | Where-Object SideIndicator -eq '=>')) {
        $validCount++
    }
}
Write-Host ('Part 1: {0} valid passports' -f $validCount)
#EndRegion

#Region Part2
$requiredFields = 'byr','iyr','eyr','hgt','hcl','ecl','pid'#,'cid'
$validCount = 0
foreach ($ppt in $passports) {
    $fields = @()
    $bits = $ppt.split(' ').split($nl)
    $bits.Where{$_}.Foreach{
        $fields += $psitem.split(':')[0]
    }

    $compare = Compare-Object $fields $requiredFields

    if (!($compare | Where-Object SideIndicator -eq '=>')) {
        $valid = $true
        # now check the validation rules
        $bits.Where{$_}.Foreach{
            $fld = $psitem
            $f = $fld.split(':')
            # byr (Birth Year) - four digits; at least 1920 and at most 2002.
            if ($f[0] -eq 'byr') {
                if(!($f[1].Length -eq 4 -and ($f[1] -ge 1920 -and $f[1] -le 2002))) {
                    $valid = $false
                }
            }
            # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
            if ($f[0] -eq 'iyr') {
                if(!($f[1].Length -eq 4 -and ($f[1] -ge 2010 -and $f[1] -le 2020))) {
                    $valid = $false
                }
            }
            # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
            if ($f[0] -eq 'eyr') {
                if(!($f[1].Length -eq 4 -and ($f[1] -ge 2020 -and $f[1] -le 2030))) {
                    $valid = $false
                }
            }
            # hgt (Height) - a number followed by either cm or in:
            if ($f[0] -eq 'hgt') {
                if(!($f[1] -match "[0-9]*(cm|in)")) {
                    $valid = $false
                } else {
                    # split off the number bit
                    $htgNum = ($f[1]-match "[0-9]*") | % { $matches[0] }

                    # If cm, the number must be at least 150 and at most 193.
                    if ($f[1] -match "[0-9]*(cm)") {
                        if(!($htgNum -ge 150 -and $htgNum -le 193)) {
                            $valid = $false
                        }
                    }

                    # If in, the number must be at least 59 and at most 76.
                    if ($f[1] -match "[0-9]*(in)") {
                        if(!($htgNum -ge 59 -and $htgNum -le 76)) {
                            $valid = $false
                        }
                    }
                }
            }
            # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
            if ($f[0] -eq 'hcl') {
                if (!($f[1] -match "#[a-z,0-9]{6}")) {
                    $valid = $false
                }
            }
            # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
            if ($f[0] -eq 'ecl') {
                if (!($f[1] -match "(amb|blu|brn|gry|grn|hzl|oth)")) {
                    $valid = $false
                }
            }
            # pid (Passport ID) - a nine-digit number, including leading zeroes.
            if ($f[0] -eq 'pid') {
                if (!($f[1] -match "(\b([0-9]{9})\b)")) {
                    $valid = $false
                }
            }
        }
        if($valid) {
            $validCount++
        }
    }
}
Write-Host ('Part 2: {0} valid passports' -f $validCount)
#EndRegion

