#!/usr/bin/env python3

# Preço de fabrico
PF = 20
# Preço de capa
PC = 24.95
# taxa de IVA
IMP = 0.23
# Taxa fixa a pagar aos autores
SPA = 0.20

# Lucro por exemplar
#
# PC = (PF + Lucro) * (1 + IMP) + SPA
# <=> PC = PF * (1 + IMP) + Lucro * (1 + IMP) + SPA
# <=> PC = PF * (1 + IMP) + Lucro * (1 + IMP) + SPA
# <=> PC - PF * (1 + IMP) - SPA = Lucro * (1 + IMP)
# <=> PC / (1 + IMP) - PF - SPA / (1 + IMP) = Lucro
custoAcrescido = 1 + IMP
lucro = PC / custoAcrescido - PF - SPA / custoAcrescido

# Calcula o lucro total
exemplares = int(input("Quantos exemplares? "))
lucroTotal = exemplares * lucro

print(f"O lucro para {exemplares} é de {lucroTotal} euros")
