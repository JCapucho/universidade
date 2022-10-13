#!/usr/bin/env python3
import math

print("Enter the coordinates in mm from the center of the board.")
x = float(input("x? "))
y = float(input("y? "))

# Points of the sectors, clockwise from the top
# Example: the sector right from the center is POINTS[5] == 6.
POINTS = (20, 1, 18, 4, 13, 6, 10, 15, 2, 17, 3, 19, 7, 16, 8, 11, 14, 9, 12, 5)

TARGET_RADIUS = 170
OUTER_RING_END = TARGET_RADIUS - 8
INNER_RING_START = 107
INNER_RING_END = INNER_RING_START - 8

CENTRAL_OUTER_RING_START = 16
CENTRAL_INNER_RING_START = 6.35

SECTOR_SIZE = math.pi * 2 / len(POINTS)

distance = math.sqrt(x**2 + y**2)

# Now for some math tricks, the coordinates are provided in cartesian
# coordinates, but if we convert them to polar coordinates then we can easily
# get the sector that the coordinates belong to
#
# The cartesian to polar coordinates is as follows:
#   r = sqrt(x^2 + y^2)
#   theta = atan2(y, x)
# where r is the distance, theta is the angle and atan2 is the 2-argument
# arctangent.
#
# But we need to do some more transformations to fit our problem, first we must
# swap x and y in the atan2 function, this is because the atan2 is
# counter-clockwise and starts from the x-axis and our problem assumes that the
# sectors are in clockwise order and start from the y-axis.
#
# Furthermore we need to rotate the result by half the sector angle, because in
# the dart board is symmetrical along the y-axis.
angle = math.atan2(x, y) + SECTOR_SIZE / 2
if angle < 0:
    angle += 2 * math.pi

# Now that we know the angle we can just divide it by the sector angle and get
# the non-decimal part.
sector = int(angle // SECTOR_SIZE)
score = POINTS[sector]

if distance <= CENTRAL_INNER_RING_START:
    score = 50
elif distance <= CENTRAL_OUTER_RING_START:
    score = 25
elif INNER_RING_END <= distance and distance <= INNER_RING_START:
    score *= 3
elif OUTER_RING_END <= distance and distance <= TARGET_RADIUS:
    score *= 2
elif distance > TARGET_RADIUS:
    score = 0

print(score)
