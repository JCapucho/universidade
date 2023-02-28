import numpy as np
import numpy.typing as npt
from dataclasses import dataclass


@dataclass
class LinRegResult:
    m: float
    b: float
    r2: float
    delta_m: float
    delta_b: float

    def apply(self, x: float | npt.NDArray) -> float | npt.NDArray:
        return self.m * x + self.b

    def dump(self):
        print(f"m={self.m}")
        print(f"b={self.b}")
        print(f"r²={self.r2}")
        print(f"Δm={self.delta_m}")
        print(f"Δb={self.delta_b}")


def linreg(x: npt.ArrayLike, y: npt.ArrayLike) -> LinRegResult:
    assert np.size(x) == np.size(y)

    # N
    data_points = np.size(x)
    #   N
    #  ___
    #  ╲    ⎛x  ⋅ y ⎞
    #  ╱    ⎝ i    i⎠
    #  ‾‾‾
    # i = 1
    mul_sum = np.sum(np.multiply(x, y))
    #   N
    #  ___
    #  ╲    x
    #  ╱     i
    #  ‾‾‾
    # i = 1
    x_sum = np.sum(x)
    #   N
    #  ___
    #  ╲    y
    #  ╱     i
    #  ‾‾‾
    # i = 1
    y_sum = np.sum(y)
    #       N                 N          N
    #      ___               ___        ___
    # N ⋅  ╲    ⎛x  ⋅ y ⎞ -  ╲    x  ⋅  ╲    x
    #      ╱    ⎝ i    i⎠    ╱     i    ╱     i
    #      ‾‾‾               ‾‾‾        ‾‾‾
    #     i = 1             i = 1      i = 1
    m_numerator = data_points * mul_sum - x_sum * y_sum
    #   N
    # ____
    # ╲
    #  ╲     2
    #  ╱    x
    # ╱      i
    # ‾‾‾‾
    # i = 1
    x2_sum = np.sum(np.square(x))
    #           2
    # ⎛  N     ⎞
    # ⎜____    ⎟
    # ⎜╲       ⎟
    # ⎜ ╲      ⎟
    # ⎜ ╱    x ⎟
    # ⎜╱      i⎟
    # ⎜‾‾‾‾    ⎟
    # ⎝i = 1   ⎠
    x_sum2 = np.square(np.sum(x))
    #                          2
    #       N        ⎛  N     ⎞
    #     ____       ⎜____    ⎟
    #     ╲          ⎜╲       ⎟
    #      ╲     2   ⎜ ╲      ⎟
    # N ⋅  ╱    x  - ⎜ ╱    x ⎟
    #     ╱      i   ⎜╱      i⎟
    #     ‾‾‾‾       ⎜‾‾‾‾    ⎟
    #     i = 1      ⎝i = 1   ⎠
    x_denom = data_points * x2_sum - x_sum2
    #   N
    # ____
    # ╲
    #  ╲     2
    #  ╱    y
    # ╱      i
    # ‾‾‾‾
    # i = 1
    y2_sum = np.sum(np.square(y))
    #           2
    # ⎛  N     ⎞
    # ⎜____    ⎟
    # ⎜╲       ⎟
    # ⎜ ╲      ⎟
    # ⎜ ╱    y ⎟
    # ⎜╱      i⎟
    # ⎜‾‾‾‾    ⎟
    # ⎝i = 1   ⎠
    y_sum2 = np.square(np.sum(y))
    #                          2
    #       N        ⎛  N     ⎞
    #     ____       ⎜____    ⎟
    #     ╲          ⎜╲       ⎟
    #      ╲     2   ⎜ ╲      ⎟
    # N ⋅  ╱    y  - ⎜ ╱    y ⎟
    #     ╱      i   ⎜╱      i⎟
    #     ‾‾‾‾       ⎜‾‾‾‾    ⎟
    #     i = 1      ⎝i = 1   ⎠
    y_denom = data_points * y2_sum - y_sum2
    #   N                 N          N
    #  ___               ___        ___
    #  ╲    ⎛x  ⋅ y ⎞ -  ╲    x  ⋅  ╲    y
    #  ╱    ⎝ i    i⎠    ╱     i    ╱     i
    #  ‾‾‾               ‾‾‾        ‾‾‾
    # i = 1             i = 1      i = 1
    # ─────────────────────────────────────
    #            N
    #          ____                 2
    #          ╲          ⎛  N     ⎞
    #           ╲     2   ⎜ ___    ⎟
    #      N ⋅  ╱    x  - ⎜ ╲    x ⎟
    #          ╱      i   ⎜ ╱     i⎟
    #          ‾‾‾‾       ⎜ ‾‾‾    ⎟
    #          i = 1      ⎝i = 1   ⎠
    m = m_numerator / x_denom
    #   N
    # ____
    # ╲            N          N          N
    #  ╲     2    ___        ___        ___
    #  ╱    x  ⋅  ╲    y  -  ╲    x  ⋅  ╲    ⎛x  ⋅ y ⎞
    # ╱      i    ╱     i    ╱     i    ╱    ⎝ i    i⎠
    # ‾‾‾‾        ‾‾‾        ‾‾‾        ‾‾‾
    # i = 1      i = 1      i = 1      i = 1
    # ────────────────────────────────────────────────
    #                  N
    #                ____                 2
    #                ╲          ⎛  N     ⎞
    #                 ╲     2   ⎜ ___    ⎟
    #            N ⋅  ╱    x  - ⎜ ╲    x ⎟
    #                ╱      i   ⎜ ╱     i⎟
    #                ‾‾‾‾       ⎜ ‾‾‾    ⎟
    #                i = 1      ⎝i = 1   ⎠
    b = (x2_sum * y_sum - x_sum * mul_sum) / x_denom
    #                                                 2
    #          ⎛  N                 N          N     ⎞
    #          ⎜ ___               ___        ___    ⎟
    #          ⎜ ╲    ⎛x  ⋅ y ⎞ -  ╲    x  ⋅  ╲    y ⎟
    #          ⎜ ╱    ⎝ i    i⎠    ╱     i    ╱     i⎟
    #          ⎜ ‾‾‾               ‾‾‾        ‾‾‾    ⎟
    #          ⎝i = 1             i = 1      i = 1   ⎠
    # ───────────────────────────────────────────────────────────
    # ⎛      N                   ⎞   ⎛      N                   ⎞
    # ⎜    ____                 2⎟   ⎜    ____                 2⎟
    # ⎜    ╲          ⎛  N     ⎞ ⎟   ⎜    ╲          ⎛  N     ⎞ ⎟
    # ⎜     ╲     2   ⎜ ___    ⎟ ⎟   ⎜     ╲     2   ⎜ ___    ⎟ ⎟
    # ⎜N ⋅  ╱    x  - ⎜ ╲    x ⎟ ⎟ ⋅ ⎜N ⋅  ╱    y  - ⎜ ╲    y ⎟ ⎟
    # ⎜    ╱      i   ⎜ ╱     i⎟ ⎟   ⎜    ╱      i   ⎜ ╱     i⎟ ⎟
    # ⎜    ‾‾‾‾       ⎜ ‾‾‾    ⎟ ⎟   ⎜    ‾‾‾‾       ⎜ ‾‾‾    ⎟ ⎟
    # ⎝    i = 1      ⎝i = 1   ⎠ ⎠   ⎝    i = 1      ⎝i = 1   ⎠ ⎠
    r2 = m_numerator**2 / (x_denom * y_denom)
    #              ______
    #             ╱ 1
    #            ╱ ── - 1
    #           ╱   2
    #          ╱   r
    # |m| ⋅   ╱    ──────
    #       ╲╱      N - 2
    delta_m = np.absolute(m) * np.sqrt((1 / r2 - 1) / (data_points - 2))
    #                 ________
    #                ╱  N
    #               ╱ ____
    #              ╱  ╲
    #             ╱    ╲     2
    #            ╱     ╱    x
    #           ╱     ╱      i
    #          ╱      ‾‾‾‾
    #         ╱       i = 1
    # Δm ⋅   ╱        ────────
    #      ╲╱             N
    delta_b = delta_m * np.sqrt(x2_sum / data_points)

    return LinRegResult(m=m, b=b, r2=r2, delta_m=delta_m, delta_b=delta_b)
