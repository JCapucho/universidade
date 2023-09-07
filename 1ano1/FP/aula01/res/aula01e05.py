#!/usr/bin/env python3
import math

# Pede ao utilizador para inserir o comprimento dos catetos
catetoA = float(input("Comprimento do cateto A (m)? "))
catetoB = float(input("Comprimento do cateto B (m)? "))

# Calcula a hipotenusa
hipo = math.sqrt(catetoA**2 + catetoB**2)

# Calcula o ângulo em radianos entre a hipotenusa e o cateto A
angleRad = math.acos(catetoA / hipo)
# Transforma de radianos para graus
angle = angleRad * 180 / math.pi

# Formata e imprime os resultados
print(f"A hipotenusa têm {hipo} m e faz um ângulo de {angle} graus com o cateto A")
