msg = "Day 3 - using Python"
print(msg)

print('Part 1:')

with open('.\day03\day03.txt') as f:
    lines = f.readlines()

work = []

for lineNum, line in enumerate(lines):
    for count, char in enumerate(line.strip()):
        if lineNum == 0:
            work.append([char])
        else:
            work[count].append(char)
    
gamma=[]
epsilon=[]

for pos in work:
    gamma.append(max(set(pos), key=pos.count))
    epsilon.append(min(set(pos), key=pos.count))

gammaJoined = int(''.join(gamma),2) # most common bit
epsilonJoined = int(''.join(epsilon),2) # least common bit

print(gammaJoined*epsilonJoined)

#### part 2 
import collections

print('Part 2:')

with open('.\day03\day03.txt') as f:
    lines = f.readlines()

work = lines.copy()
posCounter = 0
while posCounter < len(lines[0].strip()):
    loopWork = work.copy()

    # work out the most\least common bits for the loop
    gamma=[]
    epsilon=[]

    # pivot the object so we can get the most\least common bits
    pivot = []

    for lineNum, line in enumerate(loopWork):
        for count, char in enumerate(line.strip()):
            if lineNum == 0:
                pivot.append([char])
            else:
                pivot[count].append(char)
        
    for count, pos in enumerate(pivot):

        c = collections.Counter(pos)

        if c['0'] > c['1']:
            gamma.append('0')
            # 0 is most common

        elif c['0'] < c['1']:
            gamma.append('1')
            # 1 is most common

        else:
            gamma.append('1')
            # 1 and 0 appear the same
    
    # work out which values to keep
    for line in loopWork:
        if (line[posCounter] != gamma[posCounter]):
            work.remove(line)
            
            if len(work) == 1:
                oxygen = work[0]
    posCounter += 1

finalOxygen = int(oxygen,2) # most common bit

## co2 bit

work = lines.copy()
posCounter = 0
while posCounter < len(lines[0].strip()):
    loopWork = work.copy()

    epsilon=[]

    # pivot the object so we can get the most\least common bits
    pivot = []

    for lineNum, line in enumerate(loopWork):
        for count, char in enumerate(line.strip()):
            if lineNum == 0:
                pivot.append([char])
            else:
                pivot[count].append(char)
        
    for count, pos in enumerate(pivot):

        c = collections.Counter(pos)

        if c['0'] > c['1']:
            epsilon.append('1')
            # 1 is least common

        elif c['0'] < c['1']:
            epsilon.append('0')
            # 0 is least common

        else:
            epsilon.append('0')
            # 1 and 0 appear the same
    
    # work out which values to keep
    for line in loopWork:
        if (line[posCounter] != epsilon[posCounter]):
            work.remove(line)
            
            if len(work) == 1:
                co2 = work[0]
    posCounter += 1

finalCo2 = int(co2,2) # least common bit

print(finalOxygen*finalCo2)