def leibnizPi4(n):
    accum = 0
    for i in range(0, n):
        termo = (-1) ** i / (2 * i + 1)
        accum += termo
    return accum


def main():
    termos = int(input("termos? "))
    print(f"pi/4 approx {leibnizPi4(termos)}")


main()
