import os, sys
import numpy as np
import matplotlib.pyplot as plt

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(SCRIPT_DIR))

from utils.logreg import logreg_direct


def main():
    x = np.array([200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100])
    y = np.array(
        [0.6950, 4.363, 15.53, 38.74, 75.08, 125.2, 257.9, 344.1, 557.4, 690.7]
    )

    logx = np.log10(x)
    logy = np.log10(y)

    res = logreg_direct(logx, logy)

    res.dump()

    _, (ax1, ax2) = plt.subplots(1, 2)

    ax1.plot(x, y, "r+")
    x_fitted = np.linspace(np.min(x), np.max(x), 100)
    ax1.plot(x_fitted, res.apply(x_fitted))
    ax1.set(xlabel="Temperatura (K)", ylabel="Energia (J)")

    ax2.plot(logx, logy, "r+")
    ax2.plot(logx, res.log_log_reg.apply(logx))
    ax2.set(xlabel="log(Temperatura)", ylabel="log(Energia)")

    plt.show()


if __name__ == "__main__":
    main()
