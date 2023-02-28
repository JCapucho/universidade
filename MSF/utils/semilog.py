import numpy as np
import numpy.typing as npt
from dataclasses import dataclass
from .linreg import linreg, LinRegResult


@dataclass
class SemiLogRegResult:
    y0: float
    semi_log_reg: LinRegResult

    def apply(self, x: float | npt.NDArray) -> float | npt.NDArray:
        # TODO: Checkar isto
        return self.y0 * 10 ** (x * self.semi_log_reg.m)

    def dump(self):
        self.semi_log_reg.dump()
        print(f"y0={self.y0}")


def semilogreg(x: npt.ArrayLike, y: npt.ArrayLike) -> SemiLogRegResult:
    logy = np.log10(y)

    return semilogreg_direct(x, logy)


def semilogreg_direct(x: npt.ArrayLike, logy: npt.ArrayLike) -> SemiLogRegResult:
    res = linreg(x, logy)

    y0 = 10**res.b

    return SemiLogRegResult(semi_log_reg=res, y0=y0)
