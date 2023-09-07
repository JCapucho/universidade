import sys


# a)
def loadFile(fname, lst):
    numIndex = 0
    nomeIndex = 0
    nota1Index = 0
    nota2Index = 0
    nota3Index = 0

    alunos = []

    with open(fname) as txt:
        line = next(txt)
        for i, fieldName in enumerate(line.rstrip("\n").split("\t")):
            if fieldName == "Numero":
                numIndex = i
            elif fieldName == "Nome":
                nomeIndex = i
            elif fieldName == "nota1":
                nota1Index = i
            elif fieldName == "nota2":
                nota2Index = i
            elif fieldName == "nota3":
                nota3Index = i

        for line in txt:
            comps = line.rstrip("\n").split("\t")
            num = comps[numIndex]
            nome = comps[nomeIndex]
            nota1 = float(comps[nota1Index])
            nota2 = float(comps[nota2Index])
            nota3 = float(comps[nota3Index])
            alunos.append((num, nome, nota1, nota2, nota3))

    return alunos


# b) Crie a função notaFinal aqui...
def notaFinal(reg):
    return (reg[2] + reg[3] + reg[4]) / 3


# c) Crie a função printPauta aqui...
def printPauta(lst, extra=sys.stdout):
    print(f"{'Numero':<6} {'Nome':^50} {'Nota':>4}", file=extra)
    for line in lst:
        nota = notaFinal(line)
        print(f"{line[0]:<6} {line[1]:^50} {nota:2.1f}", file=extra)


# d)
def main():
    lst = []
    # ler os ficheiros
    pauta = loadFile("school1.csv", lst)
    pauta.extend(loadFile("school2.csv", lst))
    pauta.extend(loadFile("school3.csv", lst))

    # ordenar a lista
    pauta.sort()

    # mostrar a pauta
    with open("out", "w") as fd:
        printPauta(pauta, fd)


# Call main function
if __name__ == "__main__":
    main()
