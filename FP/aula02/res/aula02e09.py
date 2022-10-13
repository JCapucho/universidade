#!/usr/bin/env python3

ctp = float(input("Nota CTP? "))
cp = float(input("Nota CP? "))

NOTA_MIN = 6.5
WEIGHT_CTP = 0.3
WEIGHT_CP = 0.7

reprovado = False
final = WEIGHT_CP * cp + WEIGHT_CTP * ctp

reprovado = ctp < NOTA_MIN or cp < NOTA_MIN or final < 10

if reprovado:
    atpr = float(input("Nota ATPR? "))
    apr = float(input("Nota APR? "))

    final = WEIGHT_CP * apr + WEIGHT_CTP * atpr

    if atpr < NOTA_MIN or apr < NOTA_MIN or final < 10:
        final = 66

print(f"A sua nota final é {final:.5g}")
