import random


def main():
    # Pick a random number between 1 and 100, inclusive
    secret = random.randrange(1, 101)
    print("Can you guess my secret?")
    guessed = False
    while not guessed:
        guess = int(input("number? "))
        if guess > secret:
            print("O número inserido é mais alto que o objetivo")
        elif guess < secret:
            print("O número inserido é mais baixo que o objetivo")
        else:
            guessed = True
    print("Advinhou o número")


main()
