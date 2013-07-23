__author__ = 'Rustam Ganeyev'


def removeCopies(list):
    n = len(list)
    result = []
    lastWord = ""
    for word in list:
        if word != lastWord:
            result.append(word)
        else:
            print(word + "\n")
        lastWord = word

    return result


def main():
    letters = ["words"]
    #letters = ['a', 'b', 'c', 'ç', 'd', 'e', 'f', 'g', 'h', 'ı', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'ö', 'p', 'r', 's', 'ş',
    #       't', 'u', 'ü', 'v', 'y', 'z']
    for letter in letters:
        fileName = letter + ".txt"
        f = open(fileName)
        list = f.readlines()
        f.close()
        #operations
        list = removeCopies(list)

        #writing to file
        f = open(fileName, "w")
        f.write("".join(list))
        f.close()


main()