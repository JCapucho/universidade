import turtle
from tkinter import filedialog

# 1) Pedir nome do ficheiro
# Abre uma janela para escolher o ficheiro graficamente
name = filedialog.askopenfilename(title="Choose File")


t = turtle.Turtle()

# 2) Ler as instruções e executá-las
with open(name) as txt:
    # 2.1) Ler as instruções linha a linha
    for line in txt:
        # Remover o carater de linha nova no final da linha
        line = line.rstrip("\n")
        # 2.2) Processa a instrução
        if line == "UP":
            t.up()
        elif line == "DOWN":
            t.down()
        else:
            # Separa as coordenadas por espaços
            comps = line.split(" ")
            x = float(comps[0])
            y = float(comps[1])
            t.goto(x, y)

# 3) Esperar que o utilizador feche a janela
turtle.Screen().exitonclick()
