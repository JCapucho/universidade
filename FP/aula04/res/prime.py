import math


def isPrime(n):
    stop = int(math.sqrt(n)) + 1
    if n <= 3:
        return n > 1
    if n % 2 == 0 or n % 3 == 0:
        return False
    for r in range(5, stop, 2):
        if n % r == 0:
            return False
    return True


for n in range(1, 100):
    print(f"isPrime({n}) = {isPrime(n)}")
