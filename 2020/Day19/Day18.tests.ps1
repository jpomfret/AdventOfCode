. .\day18_v2.ps1

$testCases = @([PSCustomObject]@{
        Numbers = (0,3,6)
        Result  = 436
    },[PSCustomObject]@{
        Numbers = (1,3,2)
        Result  = 1
    },[PSCustomObject]@{
        Numbers = (1,2,3)
        Result  = 27
    },[PSCustomObject]@{
        Numbers = (2,3,1)
        Result  = 78
    },[PSCustomObject]@{
        Numbers = (3,2,1)
        Result  = 438
    },[PSCustomObject]@{
        Numbers = (3,1,2)
        Result  = 1836
    }
)

Describe 'Testing the Elves Memory Game' {
    Context 'Examples should return expected results' {
        foreach($tc in $testCases) {
            It ('Sample ({0}) should result in {1}' -f ($tc.numbers -join ','), $tc.Result) {
                (Invoke-MemoryGame -StartingNumbers $tc.Numbers).Num | Should Be $tc.Result
            }
        }
    }
}