$expenses = Get-Content .\Day01\Input.txt

# Part 1 - 514579
:expenses
foreach ($e in $expenses) {
    foreach ($f in $expenses) {
        if ([int]$e + [int]$f -eq 2020) {
            ("Part 1 answer: {0}" -f ([int]$e * [int]$f))
            break expenses
        }
    }
}

# Part 2 - 241861950
:expenses
foreach ($e in $expenses) {
    foreach ($f in $expenses) {
        foreach ($g in $expenses) {
            if ([int]$e + [int]$f + [int]$g -eq 2020) {
                ("Part 2 answer: {0}" -f ([int]$e * [int]$f * [int]$g))
                break expenses
            }
        }
    }
}