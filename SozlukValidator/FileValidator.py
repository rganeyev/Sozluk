__author__ = 'Rustam Ganeyev'

def removeCopies(list):
    n = len(list)
    result = []
    lastWord = ""
    for word in list:
        if word != lastWord:
            result.append(word)
        lastWord = word

    return result


def main():
    letters = ["a", "b"]
    for letter in letters:
        fileName = letter + ".txt"
        f = open(fileName)
        list = f.readlines()
        f.close()
        #operations
        list = removeCopies(list)


        #writing to file
        f = open(fileName, "w")
        f.write("\n".join(list))
        f.close()

main()