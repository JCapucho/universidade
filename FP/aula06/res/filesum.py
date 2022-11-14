from tkinter import filedialog


def main():
    # 1) Pedir nome do ficheiro (experimente cada alternativa):
    # Lê o nome no terminal
    # name = input("File? ")
    # Abre uma janela para escolher o ficheiro graficamente
    name = filedialog.askopenfilename(title="Choose File")

    # 2) Calcular soma dos números no ficheiro:
    total = fileSum(name)

    # 3) Mostrar a soma:
    print("Sum:", total)


def fileSum(filename):
    accum = 0

    with open(filename) as txt:
        for line in txt:
            accum += float(line)

    return accum


if __name__ == "__main__":
    main()
