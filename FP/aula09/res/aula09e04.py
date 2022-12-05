import bisect


def main():
    words = []
    with open("wordlist.txt") as file:
        for word in file:
            words.append(word.strip())

    startIdx = bisect.bisect(words, "ea")
    endIdx = bisect.bisect(words, "eb")

    len = endIdx - startIdx

    print(len)


if __name__ == "__main__":
    main()
