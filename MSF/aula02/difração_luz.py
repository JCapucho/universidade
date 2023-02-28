import os, sys
import numpy as np
import matplotlib.pyplot as plt

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(SCRIPT_DIR))

from utils.linreg import linreg


def main():
    x = np.array([222.0, 207.5, 194.0, 171.5, 153.0, 133.0, 113.0, 92.0])
    y = np.array([2.3, 2.2, 2.0, 1.8, 1.6, 1.4, 1.2, 1.0])

    res = linreg(x, y)

    res.dump()

    print(f"f(165.0) ≈ {res.apply(165.0)}cm")

    plt.plot(x, y, "r+", label="Data points")
    plt.plot(x, res.apply(x), "--k", label="Linear regression")
    plt.xlabel("L (cm)")
    plt.ylabel("X (cm)")
    plt.show()


if __name__ == "__main__":
    main()
