# don't seem to be able to get out of the loops

msg = "Starting Day 01"
print(msg)

# read in the input
f = open("C:\Github\AdventOfCode2020\Day01\sample.txt", "r")
lines = f.read().splitlines()

# part 1
for x in lines:
    for y in lines:
        sum = int(x) + int(y)
        if sum == 2020:
            answer = int(x) * int(y)
            print("Part 1 is: " + str(answer))
            break

# part 2
for x in lines:
    for y in lines:
        for z in lines:
            sum = int(x) + int(y) + int(z)
            if sum == 2020:
                answer = int(x) * int(y) * int(z)
                print("Part 2 is: " + str(answer))
