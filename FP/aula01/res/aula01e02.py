#!/usr/bin/env python3

# Pede ao utilizador para inserir o nome
nome = input("Como te chamas? ")

# Pede ao utilizador para inserir o ano em que nasceu
anoStr = input("Como te chamas? ")

# Tenta transformar de uma string para um int
ano = int(anoStr)

# Calcula a idade do utilizador em 2020
idade2020 = 2020 - ano

print(f"{nome}, em 2020 farás 33 anos.")
