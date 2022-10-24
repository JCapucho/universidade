def divisors(N):
    list = []
    for r in range(1, N // 2 + 1):
        if N % r == 0:
            list.append(r)
    return list


def categoria(N):
    accum = 0

    for div in divisors(N):
        accum += div

    if accum < N:
        return "Deficiente"
    elif accum > N:
        return "Abundante"
    else:
        return "Perfeito"


def main():
    N = int(input("Number? "))
    print(f"Divisores: {divisors(N)}")
    print(f"Categoria: {categoria(N)}")


main()
