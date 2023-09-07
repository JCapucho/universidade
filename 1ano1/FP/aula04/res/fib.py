def Fibonacci(n):
    current = 0
    next = 1
    for i in range(1, n):
        t = current
        current = current + next
        next = t
    return current


n = int(input("Quantos termos? "))
print("Fibonacci(", n, ") = ", Fibonacci(n))
