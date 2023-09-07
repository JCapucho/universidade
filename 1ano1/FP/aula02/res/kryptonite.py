print("Kryptonite phase classifier")

T = float(input("Temperature (K)? "))
P = float(input("Pressure (kPa)? "))

# Define the line that divides the GAS and SOLID forms, this can be calculated
# by using (y2 - y1)/(x2 - x1) to get the slope, replacing with the known
# points we get (50 - 0)/(400 - 0) = 50/400 = 1/8
line = 1 / 8 * T

if P > 50.0 and T > 400:
    phase = "LIQUID"
elif P < line:
    phase = "GAS"
else:
    phase = "SOLID"

print("At {:.1f} K and {:.3f} kPa, Kryptonite is in the {} phase.".format(T, P, phase))
