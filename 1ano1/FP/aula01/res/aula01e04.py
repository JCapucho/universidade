#!/usr/bin/env python3

# Pede ao utilizador para inserir o tempo em segundos
secsStr = input("Segundos (s)? ")

# Tenta transformar de uma string para um int
rawSecs = int(secsStr)

# Calculate the time components
secs = rawSecs % 60
mins = (rawSecs // 60) % 60
hours = rawSecs // 3600

# Formata e imprime os resultados
print(f"{hours:02d}:{mins:02d}:{secs:02d}")
