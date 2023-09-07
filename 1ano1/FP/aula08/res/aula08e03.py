def primesUpTo(n):
    # Create a set with all numbers from 2 to n
    initial = {i for i in range(2, n + 1)}
    for i in range(2, int(n ** 0.5) + 1):
        # Create the sieve
        if i not in initial:
            continue
        sieve = {
            i**2 + j
            for j in range(0, n - i**2 + 1, i)
        }
        initial -= sieve
    return initial


print(primesUpTo(100))
