import os, sys
import numpy as np
import matplotlib.pyplot as plt

# Import linreg from utils package
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(SCRIPT_DIR))
from utils.linreg import linreg


def main():
    POINTS = 10
    x = np.linspace(0, 2.5, POINTS)
    random = 0.5 * np.genfromtxt("random.csv", delimiter=",")

    _, (ax1, ax2) = plt.subplots(1, 2)

    y1 = 2 * x + random
    reg1 = linreg(x, y1)
    ax1.plot(x, y1, "go")
    ax1.plot(x, reg1.apply(x), "g")
    ax1.text(
        0.01, 0.99, f"$r^2={reg1.r2}$", ha="left", va="top", transform=ax1.transAxes
    )

    y2 = np.exp(x) + random
    reg2 = linreg(x, y2)
    ax2.plot(x, np.exp(x) + random, "ro")
    ax2.plot(x, reg2.apply(x), "r")
    ax2.text(
        0.01, 0.99, f"$r^2={reg2.r2}$", ha="left", va="top", transform=ax2.transAxes
    )

    plt.show()


if __name__ == "__main__":
    main()
