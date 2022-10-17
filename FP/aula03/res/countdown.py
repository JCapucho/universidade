def countdown(N):
    if N < 0:
        return
    print(N)
    countdown(N - 1)
