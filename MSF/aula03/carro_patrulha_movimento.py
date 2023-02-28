import numpy as np
import matplotlib.pyplot as plt


def main():
    VELOCIDADE_CARRO = 70 * (1000 / 3600)
    ACELERACAO_POLICIA = 2.0

    x = np.linspace(0, 25)

    # 1/2 a t^2 = v t <=> 1/2 a t^2 - v t = 0
    # <=> t = (v +- v) / a <=>

    xIntersect = (2 * VELOCIDADE_CARRO) / ACELERACAO_POLICIA

    plt.plot(x, 1 / 2 * ACELERACAO_POLICIA * x**2, "b", label="Carro A")
    plt.plot(x, VELOCIDADE_CARRO * x, "r", label="Carro patrulha")
    plt.plot(
        xIntersect,
        VELOCIDADE_CARRO * xIntersect,
        marker="o",
        markersize=10,
        markerfacecolor="black",
    )
    plt.xlabel("Tempo (segundos)")
    plt.ylabel("Distância (m)")
    plt.show()


if __name__ == "__main__":
    main()
