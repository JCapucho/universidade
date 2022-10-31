def inputFloatList():
    list = []
    while True:
        userInput = input("Insira um número ou uma linha em branco: ")
        if userInput == "":
            break
        list.append(float(userInput))
    return list


def countLower(lst, v):
    count = 0
    for ele in lst:
        if ele < v:
            count += 1
    return count


def minmax(lst):
    min = lst[0]
    max = lst[0]
    for ele in lst[1:]:
        if ele < min:
            min = ele
        elif ele > max:
            max = ele
    return (min, max)


def main():
    list = inputFloatList()
    (min, max) = minmax(list)
    print(f"O minímo é {min}, o máximo é {max}")
    avg = (max + min) / 2
    print(f"A média é {avg}")
    count = countLower(list, avg)
    print(f"{count} elementos são menores que {avg}")


main()
