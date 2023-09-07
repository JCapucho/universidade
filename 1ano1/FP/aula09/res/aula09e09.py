import math


def findZero(f, a, b, tol):
    assert b > a
    assert f(a) * f(b) < 0

    while True:
        c = (a + b) / 2

        if (b - a) / 2 < tol:
            return [a, b]

        if f(a) * f(c) > 0:
            a = c
        else:
            b = c


def main():
    func = lambda x: x + math.sin(10 * x)

    print(findZero(func, 0.2, 0.4, 0.01))
    print(findZero(func, -0.1, 0.1, 0.01))
    print(findZero(func, 0.5, 0.6, 0.01))


if __name__ == "__main__":
    main()
