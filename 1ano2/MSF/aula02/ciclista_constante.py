import os, sys
import numpy as np
import matplotlib.pyplot as plt

# Import linreg from utils package
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(SCRIPT_DIR))
from utils.linreg import linreg


def main():
    x = np.arange(0, 10, 1)
    y = np.array([0.00, 0.735, 1.363, 1.739, 2.805, 3.814, 4.458, 4.955, 5.666, 6.329])

    res = linreg(x, y)

    res.dump()

    print(f"Velocidade média é {res.m * 60} km/h")

    # Polyfit
    (m, b) = np.polyfit(x, y, 1)

    print(f"m: ours={res.m} polyfit={m}")
    print(f"b: ours={res.b} polyfit={b}")

    plt.plot(x, y, "r+", label="Data points")
    plt.plot(x, res.apply(x), "--k", label="Linear regression")
    plt.plot(x, m * x + b, "--r", label="Linear regression (polyfit)")
    plt.xlabel("Tempo (min)")
    plt.ylabel("Distância (km)")
    plt.show()


if __name__ == "__main__":
    main()
