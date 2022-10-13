#!/usr/bin/env python3

# Pede ao utilizador para inserir a temperatura em celsius
valorStr = input("Temperature (ºC)? ")

# Tenta transformar de uma string para um float
valor = float(valorStr)

# Converte de celsius para fahrenheit
valorFahrenheit = 1.8 * valor + 32

# Mostra ao utilizador o resultado
print(f"{valor} ºC = {valorFahrenheit} ºF")
