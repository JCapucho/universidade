#!/usr/bin/env python3

import sys


# Calculate the frequency of letters in a file
def countLetters(file):
    dict = {}
    # Loop trough each char in the file
    for line in file:
        for c in line:
            # Check if it's a letter
            if c.isalpha():
                # Convert to lowercase and increase count
                key = c.lower()
                # Use `get` to get a default value in case the key isn't present
                # in the dictionary
                dict[key] = dict.get(key, 0) + 1
    return dict


def main():
    # Check that exactly two arguments were passed:
    # program and filename
    if len(sys.argv) != 2:
        print("Use: program [file]")
        exit(1)

    with open(sys.argv[1], "r") as file:
        # Get a dictionary with the frequency of each letter
        lettersFreq = countLetters(file)
        # Iterate over the dictionary keys sorted
        for c in sorted(lettersFreq, key=lambda c: lettersFreq[c], reverse=True):
            # print the letter and their respective frequency
            print(f"{c} {lettersFreq[c]}")


if __name__ == "__main__":
    main()
