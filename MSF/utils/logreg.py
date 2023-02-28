import numpy as np
import numpy.typing as npt
from dataclasses import dataclass
from .linreg import linreg, LinRegResult


@dataclass
class LogRegResult:
    c: float
    log_log_reg: LinRegResult

    def apply(self, x: float | npt.NDArray) -> float | npt.NDArray:
        return self.c * x**self.log_log_reg.m

    def dump(self):
        self.log_log_reg.dump()
        print(f"c={self.c}")


def logreg(x: npt.ArrayLike, y: npt.ArrayLike) -> LogRegResult:
    logx = np.log10(x)
    logy = np.log10(y)

    return logreg_direct(logx, logy)


def logreg_direct(logx: npt.ArrayLike, logy: npt.ArrayLike) -> LogRegResult:
    res = linreg(logx, logy)

    c = 10**res.b

    return LogRegResult(log_log_reg=res, c=c)
