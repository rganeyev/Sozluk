import codecs
import json


def symbol(x):
    return {
        'â': 'a',
        'î': 'i',
        'ı': 'i',
        'ğ': 'g',
        'ç': 'c',
        'ö': 'o',
        'ô': 'o',
        'ş': 's',
        'ü': 'u',
        'û': 'u',
        'ú': 'u',
        "'": '',
        '-': '',
        '¯': '',
        '(': '',
        ')': '',
    }.get(x, x)


def search_word(word):
    word = word.lower()

    result = ''
    for ch in word:
        sym = symbol(ch)
        if not ('a' <= sym <= 'z' or sym in ' .'):
            print(word)
        result += sym
    return result


def jsonify():
    letters = ['a', 'b', 'c', 'ç', 'd', 'e', 'f', 'g', 'h', 'ı', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'ö', 'p', 'r', 's',
               'ş', 't', 'u', 'ü', 'v', 'y', 'z']

    for letter in letters:
        filename = letter + '.txt'
        f = codecs.open(filename, 'r', 'utf-8')
        lines = f.readlines()
        f.close()

        filename = letter + '.json'
        f = codecs.open(filename, 'w', 'utf-8-sig')

        for line in lines:
            # print(line)
            index = line.index(':')
            word = line[0:index].strip()
            definition = line[index + 1:].strip()
            search = search_word(word)
            result = {'word': word, 'definition': definition, 'search': search}
            f.write(json.dumps(result, ensure_ascii=False))
            f.write('\n')

        f.close()


if __name__ == "__main__":
    jsonify()
