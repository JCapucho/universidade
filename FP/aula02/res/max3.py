#!/usr/bin/env python3

x1 = float(input("number? "))
x2 = float(input("number? "))
x3 = float(input("number? "))
x4 = float(input("number? "))

mx = x1

if x2 > mx:
    mx = x2
if x3 > mx:
    mx = x3
if x4 > mx:
    mx = x4

print("Maximum:", mx)
