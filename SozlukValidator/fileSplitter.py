__author__ = 'rganeyev'

import codecs


def symbol(x):
    return {
        'â': 'a',
        'î': 'i'
    }.get(x, x)


def main():
    letters = ['a', 'b', 'c', 'ç', 'd', 'e', 'f', 'g', 'h', 'ı', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'ö', 'p', 'r', 's',
               'ş', 't', 'u', 'ü', 'v', 'y', 'z']

    f = codecs.open('words.txt', 'r', 'utf-8')
    words = f.readlines()
    f.close()
    cur = 0
    wordsCount = len(words)

    for letter in letters:
        list = []
        while cur < wordsCount:
            word = words[cur]
            lowerWord = word.lower()
            print(word)
            ch = symbol(lowerWord[0])
            if ch != letter:
                break
            list.append(word)
            cur += 1
        outfile = codecs.open(letter + '.txt', 'w', 'utf-8')
        outfile.write("".join(list))
        outfile.close()


main()