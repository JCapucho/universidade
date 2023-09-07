# isLeapYear(year) deve devolver True se year é um ano bissexto
# e False se é um ano comum.
# (See: https://en.wikipedia.org/wiki/Leap_year)
def isLeapYear(year):
    # Se um ano for divisível por 100 este só será bissexto se também
    # for divisível por 400, caso contrário só o é se for divisível por 4
    #
    # Nós não precisamos de verificar se o número é divisível por 100 quando
    # verificamos se é divisível por 400, visto que 400 é divisível por 4, logo
    # mesmo que o ano não seja divisível por 100 só será divisível por 400 se
    # também o for por 4
    return (year % 100 != 0 and year % 4 == 0) or year % 400 == 0


# monthDays deve devolver o número de dias de um dado mês num dado ano.
# Por exemplo, monthDays(2004, 2) deve devolver 29.
def monthDays(year, month):
    # This tuple contains the days in each month (on a common year).
    # For example: MONTHDAYS[3] is the number of days in March.
    MONTHDAYS = (0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
    days = MONTHDAYS[month]
    # Update the number of days returned by February (month 2)
    # to 29 if it's a leap year
    if isLeapYear(year) and month == 2:
        days = 29
    return days


# nextDay deve devolver o dia a seguir a uma dada data.
# Por exemplo, nextDay(2017, 1, 31) deve devolver (2017, 2, 1)
def nextDay(year, month, day):
    # Start by incrementing the day
    day += 1

    maxDays = monthDays(year, month)
    # Check if day is larger than the number of days in that month
    if day > maxDays:
        # Jump to the next month and reset the day to 1
        day = 1
        month += 1
        # Check if month is larger than the number of months in a year (12 days)
        if month > 12:
            # Jump to the next year and reset the month to 1
            month = 1
            year += 1

    return year, month, day


# dateIsValid deve devolver True se os seus argumentos formarem uma data válida
# e devolver False no caso contrário.
# Por exemplo, dateIsValid(1980, 2, 29) deve devolver True,
# dateIsValid(1980, 2, 30) deve devolver False.
def dateIsValid(year, month, day):
    # A data é válida se o mês estiver entre [1, 12] e o dia estiver
    # entre [1, monthDays(year, month)]
    #
    # A função protege-se contra valores negativos nos meses e dias, que serão
    # inválidos, no entanto o ano pode ser negativo (AC)
    monthOkay = month > 0 and month <= 12
    maxDays = monthDays(year, month)
    dayOkay = day > 0 and day <= maxDays
    return monthOkay and dayOkay


# previousDay deve devolver o dia anterior a uma dada data.
# Por exemplo, previousDay(1980, 3, 1) deve devolver (1980, 2, 29)
def previousDay(year, month, day):
    # Começa por subtrair 1 ao dia
    day -= 1
    # Se o dia for menor de 1, precisamos de voltar atrás um mês
    if day < 1:
        month -= 1
        # Se o mês for menor de 1, precisamos de voltar atrás um ano
        if month < 1:
            month = 12
            year -= 1
        # Calcula só o novo dia após já saber-se o mês e ano final, visto
        # que estes afetam o resultado
        day = monthDays(year, month)
    return year, month, day


# This is the main function
def main():
    print("Was", 2017, "a leap year?", isLeapYear(2017))  # False?
    print("Was", 2016, "a leap year?", isLeapYear(2016))  # True?
    print("Was", 2000, "a leap year?", isLeapYear(2000))  # True?
    print("Was", 1900, "a leap year?", isLeapYear(1900))  # False?
    print("Was", 1800, "a leap year?", isLeapYear(1800))  # False?

    print("January 2017 had", monthDays(2017, 1), "days")  # 31?
    print("February 2017 had", monthDays(2017, 2), "days")  # 28?
    print("February 2016 had", monthDays(2016, 2), "days")  # 29?
    print("February 2000 had", monthDays(2000, 2), "days")  # 29?
    print("February 1900 had", monthDays(1900, 2), "days")  # 28?

    y, m, d = nextDay(2017, 1, 30)
    print(y, m, d)  # 2017 1 31 ?
    y, m, d = nextDay(2017, 1, 31)
    print(y, m, d)  # 2017 2 1 ?
    y, m, d = nextDay(2017, 2, 28)
    print(y, m, d)  # 2017 3 1 ?
    y, m, d = nextDay(2016, 2, 29)
    print(y, m, d)  # 2016 3 1 ?
    y, m, d = nextDay(2017, 12, 31)
    print(y, m, d)  # 2018 1 1 ?


# call the main function
if __name__ == "__main__":
    main()
