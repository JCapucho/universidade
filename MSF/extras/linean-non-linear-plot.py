import numpy as np
import matplotlib.pyplot as plt


def main():
    POINTS = 10
    x = np.linspace(0, 2.5, POINTS)
    random = 0.5 * np.genfromtxt("random.csv", delimiter=",")

    _, (ax1, ax2) = plt.subplots(1, 2)

    ax1.plot(x, 2 * x + random, "go")
    ax2.plot(x, np.exp(x) + random, "ro")

    plt.show()


if __name__ == "__main__":
    main()
