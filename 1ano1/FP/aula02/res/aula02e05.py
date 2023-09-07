#!/usr/bin/env python3

secs = int(input("seconds? "))

rate = 0.12
cost = rate

if secs > 60:
    remainingSecs = secs - 60
    cost += remainingSecs / 60 * rate

print("The cost of the call is", cost, "euros")
