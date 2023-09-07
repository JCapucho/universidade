#!/usr/bin/env python3

# Minutos por km a andar
vAndar = 10
# Minutos por km a correr
vCorrer = 6

# Minutos de saída de casa 6:52
minutosSaida = 6 * 60 + 52

# Distâncias a andar e a correr
distanciaAndar = float(input("Quanto andou (km)? "))
distanciaCorrer = float(input("Quanto correu (km)? "))

# Distância total percorrida após sair de casa e antes de começar regressar
distanciaTotal = distanciaAndar + distanciaCorrer
# Tempo gasto após sair de casa e antes de começar regressar
tempoFora = distanciaAndar * vAndar + distanciaCorrer * vCorrer

# Tempo gasto a regressar
tempoDentro = distanciaTotal * vAndar

# Tempo total
minutosChegada = minutosSaida + tempoFora + tempoDentro
# Formatar
horas = int(minutosChegada // 60)
minutos = int(minutosChegada % 60)

print(f"Chego a casa as {horas:02d}:{minutos:02d}")
