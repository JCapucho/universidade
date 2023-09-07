import numpy as np
import matplotlib.pyplot as plt


def main():
    POINTS = 10
    x = np.linspace(0, 2.5, POINTS)
    random = np.genfromtxt("random.csv", delimiter=",")

    plt.plot(x, 2 * x**2.5 + random, "go")

    plt.show()


if __name__ == "__main__":
    main()
