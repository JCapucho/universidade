import os, sys
import numpy as np
import matplotlib.pyplot as plt

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(SCRIPT_DIR))

from utils.semilog import semilogreg_direct


def main():
    x = np.arange(0, 50, 5)
    y = np.array(
        [9.676, 6.355, 4.261, 2.729, 1.862, 1.184, 0.7680, 0.4883, 0.3461, 0.2119]
    )

    logy = np.log10(y)

    res = semilogreg_direct(x, logy)

    res.dump()

    _, (ax1, ax2) = plt.subplots(1, 2)

    ax1.plot(x, y, "r+")
    x_fitted = np.linspace(np.min(x), np.max(x), 100)
    ax1.plot(x_fitted, res.apply(x_fitted))
    ax1.set(xlabel="Tempo (dias)", ylabel="Emissão (mCi)")

    ax2.plot(x, logy, "r+")
    ax2.plot(x, res.semi_log_reg.apply(x))
    ax2.set(xlabel="Tempo (dias)", ylabel="log(Emissão)")

    plt.show()


if __name__ == "__main__":
    main()
