def main():
    accum = 0
    n = 0

    while True:
        s = input("Introduza um número ou prima enter: ")
        if s == "":
            break
        accum += float(s)
        n += 1

    if n == 0:
        return

    print(f"A média é {accum / n}")


main()
