#!/usr/bin/env python3

# Pede ao utilizador para inserir a primeira velocidade
v1Str = input("Insira a primeira velocidade (v1): ")
# Tenta transformar a string inserida num float
v1 = float(v1Str)

# Pede ao utilizador para inserir a segunda velocidade
v2Str = input("Insira a segunda velocidade (v2): ")
# Tenta transformar a string inserida num float
v2 = float(v2Str)

# Note que a velocidade média é calculada pela distância percorrida
# a dividir pelo tempo total: v=d/t.
#
# Como nós temos duas velocidades, v1 e v2, e a distância percorrida
# é a mesma nas duas, as velocidades são definidas por v1=d/t1 e v2=d/t2,
# logo queremos calcular v=2d/(t1 + t2) ou seja
# v=2d/(d/v1 + d/v2)
# <=> v = 2d/((dv2 + dv1)/v1v2)
# <=> v = 2d/(d(v1 + v2)/v1v2)
# <=> v = 2dv1v2/(d(v1 + v2)
# <=> v = 2v1v2/(v1 + v2)
v = 2 * v1 * v2 / (v1 + v2)

# Formata e imprime os resultados
print("A velocidade média é", v)
