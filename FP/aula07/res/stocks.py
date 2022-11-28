# Constantes para indexar os tuplos:
NAME, DATE, OPEN, MAX, MIN, CLOSE, VOLUME = 0, 1, 2, 3, 4, 5, 6

import math


def main():
    lst = loadStockFile("nasdaq.csv")
    # Show just first and last tuples:
    print("first:", lst[1])
    print("last:", lst[-1])

    print("a) totVol=", totalVolume(lst))

    print("b) maxVal=", maxValorization(lst))

    stocksDic = stocksByDateByName(lst)
    print("c) CSCO@11:", stocksDic["2020-10-12"]["CSCO"])
    print("c) AMZN@22:", stocksDic["2020-10-22"]["AMZN"])

    port = {"NFLX": 100, "CSCO": 80}
    print("d) portfolio@01:", portfolioValue(stocksDic, port, "2020-10-01"))
    print("d) portfolio@30:", portfolioValue(stocksDic, port, "2020-10-30"))


def loadStockFile(filename):
    lst = []
    with open(filename) as f:
        for line in f:
            parts = line.strip().split("\t")
            name = parts[NAME]
            date = parts[DATE]
            tup = (
                name,
                date,
                float(parts[OPEN]),
                float(parts[MAX]),
                float(parts[MIN]),
                float(parts[CLOSE]),
                int(parts[VOLUME]),
            )
            lst.append(tup)
    return lst


def totalVolume(lst):
    totVol = {}

    for transaction in lst:
        name = transaction[NAME]
        totVol[name] = totVol.get(name, 0) + transaction[VOLUME]

    return totVol


def maxValorization(lst):
    vMax = {}

    for transaction in lst:
        date = transaction[DATE]
        relVal = transaction[OPEN] / transaction[CLOSE] - 1

        lastMax = vMax.get(date, ("", -math.inf))[1]

        if relVal > lastMax:
            vMax[date] = (transaction[NAME], relVal)

    return vMax


def stocksByDateByName(lst):
    dic = {}

    for transaction in lst:
        date = transaction[DATE]
        name = transaction[NAME]

        dateDic = dic.setdefault(date, {})
        dateDic[name] = transaction

    return dic


def portfolioValue(stocks, portfolio, date):
    assert date in stocks
    val = 0.0

    stocksInDate = stocks[date]

    for company, transaction in stocksInDate.items():
        actions = portfolio.get(company, 0)
        val += actions * transaction[CLOSE]

    return val


if __name__ == "__main__":
    main()
