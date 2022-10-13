#!/usr/bin/env python3

age = int(input("Age? "))

if age < 0:
    print("ERROR: invalid age!")
    exit(1)

print("Age:", age)

if age < 13:
    cat = "child"
elif age < 20:
    cat = "teenager"
else:
    cat = "grown-up"

print("Category:", cat)
