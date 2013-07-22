__author__ = 'rganeyev'

def removeCopies(list):
    n = len(list)
    result = [];
    for i in range(0, n - 1):
        if list[i] != list[i + 1]


def main():
    letters = ["a", "b"];
    for letter in letters:
        fileName = letter + ".txt"
        f = open(fileName)
        list = f.readlines()

        removeCopies(list)

main()