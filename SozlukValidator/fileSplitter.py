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
    words_count = len(words)

    for letter in letters:
        letter_list = []
        while cur < words_count:
            word = words[cur]
            lower_word = word.lower()
            print(word)
            ch = symbol(lower_word[0])
            if ch != letter:
                break
            letter_list.append(word)
            cur += 1
        outfile = codecs.open(letter + '.txt', 'w', 'utf-8')
        outfile.write("".join(letter_list))
        outfile.close()


main()
