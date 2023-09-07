def shorten(str):
    abrv = ""
    for c in str:
        if c.isupper():
            abrv += c
    return abrv


def main():
    assert shorten("Universidade de Aveiro") == "UA"
    assert shorten("United Nations Organization") == "UNO"
    assert shorten("João Capucho") == "JC"
    assert shorten("João Pinto Capucho") == "JPC"


main()
