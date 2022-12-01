import enum
from re import L


msg = "Day 3 - using Python"
print(msg)

print('Part 2:')

with open('.\day04\day04.txt') as f:
    lines = f.read()

numbers = (lines.split("\n\n")[0]).split(',')
boards = lines.split("\n\n")[1:]

newBoards = []
for b in boards:

    board = b.split("\n")
    
    for count, n in enumerate(board):
        board[count] = n.split()

    newBoards.append(board)

# newBoards contains the board as a list of lists
#print(newBoards)


def mark_whole_board(board):
    for rNum, row in enumerate(board):
        for nNum, num in enumerate(row):
            board[rNum][nNum] = '-'


def bingo_checker(boards):
    #print('checking for bingo')
    boards
    for bNum, board in enumerate(boards):
        for rNum, row in enumerate(board):

            # zip to test for vertical bingos
            verticals = list(zip(*board))
            if (all(element == 'X' for element in verticals[rNum])):
               
                # if all but one have already won
                if ([item[0][0] for item in newBoards].count('-') == len(boards)-1):
                   
                    score = total_board(boards[bNum])
                    #print(score)
                    #print(num)
                    print(score * int(num))

                    quit()
                else:
                    # mark the whole board and carry on
                    mark_whole_board(boards[bNum])
            
            # test for horizontal bingos
            if (all(element == 'X' for element in boards[bNum][rNum])):
                
                # if it's the last board - bingo!
                if ([item[0][0] for item in newBoards].count('-') == len(boards)-1):
                    
                    score = total_board(boards[bNum])
                    #print(score)
                    #print(num)
                    print(score * int(num))

                    quit()
                else:
                    # mark the whole board and carry on
                    mark_whole_board(boards[bNum])
            
            

def call_number(calledNumber, boards):
    #print("we called " + calledNumber)
    
    for bNum, board in enumerate(boards):
        for rNum, row in enumerate(board):
            for nNum, num in enumerate(row):
                if num == calledNumber:
                    boards[bNum][rNum][nNum] = 'X'
                    #print('got one')
                    bingo_checker(boards)


def total_board(board):
    total = 0
    for row in board:
        for num in row:
            if (num != 'X'):
                total += int(num)
    return total


for num in numbers:
    call_number(num,newBoards)