msg = "Day 1 - using Python"
print(msg)

print('Part 1:')

i=0

with open('.\day01\day01.txt') as f:
    lines = f.readlines()

prevLine=''

for line in lines:
    currentline = int(line)
    if prevLine != '' and currentline > prevLine:
        i=i+1
    
    prevLine = currentline

print(i)

### PART 2

print('Part 2:')
i=0

with open('.\day01\day01.txt') as f:
    lines = f.readlines()

    prev = ''    

    for l in range(len(lines)-2):
        current = int(lines[l]) + int(lines[l+1]) + int(lines[l+2])
        if prev != '' and current > prev:
            i=i+1

        prev = current

    print(i)
