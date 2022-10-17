def mdc(a, b):
    r = a % b
    if r == 0:
        return b
    else:
        return mdc(b, r)


a = int(input("a? "))
b = int(input("b? "))
print("mdc(a, b) = ", mdc(a, b))
