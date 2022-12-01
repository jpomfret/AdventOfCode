msg = "Day 2 - using Python"
print(msg)

print('Part 1:')

horizontal=0
depth=0

with open('.\day02\day02.txt') as f:
    lines = f.readlines()

    for line in lines:
        match line.split( )[0]:
            case 'forward':
                horizontal = horizontal + int(line.split( )[-1])
            case 'down':
                depth = depth + int(line.split( )[-1])
            case 'up':
                depth = depth - int(line.split( )[-1])

print('Part 1: ' + str(horizontal*depth))



print('Part 2:')

horizontal=0
depth=0
aim = 0

with open('.\day02\day02.txt') as f:
    lines = f.readlines()

    for line in lines:
        match line.split( )[0]:
            case 'forward':
                horizontal = horizontal + int(line.split( )[-1])
                depth = depth + (aim * int(line.split( )[-1]))
            case 'down':
                aim = aim + int(line.split( )[-1])
            case 'up':
                aim = aim - int(line.split( )[-1])

print('horizontal: ' + str(horizontal))
print('depth: ' + str(depth))

print('Part 2: ' + str(horizontal*depth))