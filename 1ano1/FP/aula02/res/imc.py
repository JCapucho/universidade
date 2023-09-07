#!/usr/bin/env python3

print("Índice de Massa Corporal")

altura = float(input("Altura (m)? "))
peso = float(input("Peso (kg)? "))

imc = peso / altura**2

print("IMC:", imc, "kg/m2")

# Determinar a categoria de IMC:
if imc < 18.5:
    categoria = "Magro"
elif imc < 25:
    categoria = "Saudável"
elif imc < 30:
    categoria = "Forte"
else:
    categoria = "Obeso"

print("Categoria:", categoria)
