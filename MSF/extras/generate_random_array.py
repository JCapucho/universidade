import numpy as np


def main():
    random = 0.5 * np.random.rand(10)
    np.savetxt("random.csv", random, delimiter=",")


if __name__ == "__main__":
    main()
