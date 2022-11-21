def listContacts(dic):
    """Print the contents of the dictionary as a table, one item per row."""
    print("{:>12s} : {:^30} : {}".format("Numero", "Nome", "Morada"))
    for num in dic:
        contactData = dic[num]
        print("{:>12s} : {:^30} : {}".format(num, contactData[0], contactData[1]))


def filterPartName(contacts, partName):
    """Returns a new dict with the contacts whose names contain partName."""
    searchResults = {}
    for (number, data) in contacts.items():
        if partName in data[0]:
            searchResults[number] = data
    return searchResults


def menu():
    """Shows the menu and gets user option."""
    print()
    print("(L)istar contactos")
    print("(A)dicionar contacto")
    print("(R)emover contacto")
    print("Procurar (N)úmero")
    print("Procurar (P)arte do nome")
    print("(T)erminar")
    op = input("opção? ").upper()  # converts to uppercase...
    return op


def main():
    """This is the main function containing the main loop."""

    contactos = {
        "234370200": ("Universidade de Aveiro", "Santiago, Aveiro"),
        "727392822": ("Cristiano Aveiro", "Leiria"),
        "387719992": ("Maria Matos", "Lisboa"),
        "887555987": ("Marta Maia", "Coimbra"),
        "876111333": ("Carlos Martins", "Porto"),
        "433162999": ("Ana Bacalhau", "Faro"),
    }

    op = ""
    while op != "T":
        op = menu()
        if op == "T":
            print("Fim")
        elif op == "L":
            print("Contactos:")
            listContacts(contactos)
        elif op == "A":
            number = input("número: ")
            name = input("nome: ")
            morada = input("morada: ")
            contactos[number] = (name, morada)
        elif op == "R":
            number = input("número: ")
            del contactos[number]
        elif op == "N":
            number = input("número: ")
            if number in contactos:
                listContacts({number: contactos[number]})
            else:
                print(number)
        elif op == "P":
            partName = input("nome parcial: ")
            results = filterPartName(contactos, partName)
            listContacts(results)
        else:
            print("Não implementado!")


main()
