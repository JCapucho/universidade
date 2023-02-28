import sympy
import numpy as np
import matplotlib.pyplot as plt


def main():
    VELOCIDADE_TERMINAL = 6.8
    ACELERACAO_GRAVITICA = 9.8

    vT, g, t = sympy.symbols("vT, g, t")
    y = (vT**2 / g) * sympy.log(sympy.cosh(g * t / vT))

    y2 = y.subs([(vT, VELOCIDADE_TERMINAL), (g, ACELERACAO_GRAVITICA)])

    y_lam = sympy.lambdify(t, y2, "numpy")

    diff_y = sympy.diff(y2, t)
    diff_y_lam = sympy.lambdify(t, diff_y, "numpy")

    diff2_y = sympy.diff(diff_y, t)
    diff2_y_lam = sympy.lambdify(t, diff2_y, "numpy")

    acel = g - (g / vT**2) * diff_y * sympy.Abs(diff_y)
    acel2 = acel.subs([(vT, VELOCIDADE_TERMINAL), (g, ACELERACAO_GRAVITICA)])
    acel_lam = sympy.lambdify(t, acel2, "numpy")

    xIntersect = sympy.nsolve(y2 - 20, t, 3.4)
    vIntersect = diff_y_lam(np.float64(xIntersect))
    aIntersect = diff2_y_lam(np.float64(xIntersect))

    print("Tempo:", xIntersect)
    print("Velocidade:", vIntersect)
    print("Aceleração:", aIntersect)

    x = np.linspace(0, 4)

    plt.plot(x, y_lam(x), "b", label="Distância")
    plt.plot(x, diff_y_lam(x), "g", label="Velocidade")
    plt.plot(x, diff2_y_lam(x), "r", label="Açeleração (automática)")
    plt.plot(x, acel_lam(x), "black", label="Açeleração (manual)")

    plt.axhline(y=20, color="purple")
    plt.axvline(x=xIntersect, color="purple")
    plt.plot(xIntersect, 20, marker="o", markersize=6, color="black")
    plt.plot(xIntersect, vIntersect, marker="o", markersize=6, color="black")
    plt.plot(xIntersect, aIntersect, marker="o", markersize=6, color="black")

    plt.xlabel("Tempo (segundos)")
    plt.legend(loc="upper left")
    plt.show()


if __name__ == "__main__":
    main()
