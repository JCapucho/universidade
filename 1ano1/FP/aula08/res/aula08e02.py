def main():
    lastNames = {}
    with open("names.txt", "r") as file:
        file.readline()
        for line in file:
            parts = line.split()
            lastName = parts[-1]
            firstName = parts[0]
            names = lastNames.setdefault(lastName, set())
            names.add(firstName)

    for lastName, names in lastNames.items():
        print(f"{lastName} : {names}")


main()
