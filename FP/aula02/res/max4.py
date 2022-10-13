#!/usr/bin/env python3
# coding: utf-8
# This program finds the maximum of two numbers.
# It uses the built-in max function.
# Can you do it with a conditional statement (if / if-else) instead?
# Sure can :)

x1 = float(input("number? "))
x2 = float(input("number? "))

# Use a conditional statement instead of max function!
mx = x1

if x2 > x1:
    mx = x2

print("Maximum:", mx)
