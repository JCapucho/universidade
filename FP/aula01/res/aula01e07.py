#!/usr/bin/env python3

# Número de andares no prédio e a sua altura em metros
andares = int(input("Quantos andares? "))
aAltura = 3
# Número de moradores por andar
aMorador = int(input("Quantos moradores por andar? "))
# Número de viagens por dia por morador
mViagens = 2
# velocidade em metros por segundo
velocidade = 1

# Tempo em segundos gastos num andar por n° do andar (s/i) por dia
andarTempo = mViagens * aMorador * aAltura / velocidade

# sum(andares, 1, \a -> andarTempo * a)
# <=> andarTempo * (andares * (1 + andares)) / 2
# <=> andarTempo * (andares + andares^2) / 2

# Tempo gasto por dia em segundos
tempoDia = andarTempo * (andares + andares**2) / 2

# Tempo gasto por ano
tempo = tempoDia * 365
tempoMinutos = int(tempo / 60 % 60)
tempoHoras = int(tempo // 3600)

print(
    f"O elevador está em funcionamento {tempoHoras:d} horas e {tempoMinutos:d} minutos por ano"
)
