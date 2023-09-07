import bisect
import sys


def nextMatch(words, prefix):
    startIdx = bisect.bisect(words, prefix)

    next = set()

    for word in words[startIdx:]:
        if not word.startswith(prefix):
            break
        elif len(word) <= len(prefix):
            continue

        next.add(word[len(prefix)])

    return next


def main(args):
    if len(args) < 1 or len(args) > 2:
        print("Usage: [program] <words> <prefix>?")
        exit(1)

    wordsFile = args[0]

    words = []
    with open(wordsFile) as file:
        for word in file:
            words.append(word.strip())

    if len(args) == 2:
        print(nextMatch(words, args[1]))
        return

    print("Entering interactive mode")

    prefix = input("Insert a prefix> ")

    while True:
        next = list(nextMatch(words, prefix))

        if len(next) == 0:
            break

        for i, c in enumerate(next):
            print(f"{i}) {c}")

        print("q) exit the program")
        selection = input("Select an option> ")

        if selection == "q":
            break

        try:
            num = int(selection)
            assert num < len(next)
        except:
            print("Invalid selection")
            continue

        prefix += next[num]

        print(prefix)

    print("goodbye")


if __name__ == "__main__":
    main(sys.argv[1:])
