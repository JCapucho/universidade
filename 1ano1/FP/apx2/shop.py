# Pode correr o programa sem argumentos:
#   python3 shop
# ou passando outros ficheiros de produtos como argumento:
#   python3 shop produtos1.txt ...

# Define some constants to allow for better readibility while indexing
# into an entry of the `produtos` dictionary.
NOME, SECCAO, PRECO_BASE, TAXA = 0, 1, 2, 3


def loadDataBase(fname, produtos):
    """Lê dados do ficheiro fname e atualiza/acrescenta a informação num
    dicionário de produtos com o formato {código: (nome, secção, preço, iva), ...}.
    """
    with open(fname, "r") as db:
        # Skip heading
        db.readline()
        # Process each line in the file as a separate entry
        for entry in db:
            # Remove leading newlines and split the line by semicolons (;)
            comps = entry.rstrip().split(";")
            # The first part will have the product code
            code = comps[0]
            # Create or update an entry in the `produtos` dictionary, with
            # a tuple of the form (nome, secção, preço, iva)
            produtos[code] = (
                comps[1],
                comps[2],
                # Parse the preço to a float
                float(comps[3]),
                # Remove the percentage symbol from the iva field, convert it
                # to a float and also convert from a percentage to a regular number
                float(comps[4].rstrip("%")) / 100,
            )


def registaCompra(produtos):
    """Lê códigos de produtos (ou códigos e quantidades),
    mostra nome, quantidade e preço final de cada um,
    e devolve dicionário com {codigo: quantidade, ...}
    """
    # Create a dictionary to keep track of the items bought and their
    # respective quantities
    carrinho = {}

    while True:
        # Keep asking the user for input
        userInput = input("Code? ")
        # If the user inputs only whitespace or nothing at all stop the loop
        if userInput.strip() == "":
            break

        # Split the user input by whitespace
        parts = userInput.split()
        code = parts[0]

        # Check if there's a product with the user provided code in the
        # `produtos` dictionary otherwise ignore the user command
        if code in produtos:
            # If the user inserted more than the code then try to parse
            # it as the amount, if it isn't a valid amount then print an
            # error and ignore the user command, if the user didn't provide
            # an amount assume that it's 1
            if len(parts) > 1:
                try:
                    amount = int(parts[1])
                    assert amount > 0
                except:
                    print("Amount is not a valid number")
                    continue
            else:
                amount = 1

            produto = produtos[code]

            # Calculate the price for the product with the requested amount
            # and tax applied
            precoBruto = produto[PRECO_BASE]
            precoUni = precoBruto * (1 + produto[TAXA])
            precoTotal = precoUni * amount

            print(f"{produto[NOME]} {amount} {precoTotal:.2f}")

            # Update the dictionary with more `amount` if it already existed
            # otherwise create a new entry
            carrinho[code] = carrinho.get(code, 0) + amount

    return carrinho


def fatura(produtos, compra):
    """Imprime a fatura de uma dada compra."""
    # Iterate over all the products the user wishes to buy and group them by
    # section
    sections = {}
    for item, amount in compra.items():
        produto = produtos[item]
        # Get the name of the section this product belongs to
        sectionName = produto[SECCAO]
        # Store all the products belonging to the same section in a list
        section = sections.setdefault(sectionName, [])
        # Add the current product data to the section's list with the amount
        # of the product that the user wishes to buy (avoids a lookup later on
        # since we are already iterating over the products)
        section.append(produto + (amount,))

    # Keep track of the total prices without tax, only tax and both
    totalBruto = 0
    totalIva = 0
    totalLiquido = 0

    # Iterate over the sections printing them in a heading and their products
    # inside them, formatted with the amount, name, tax and the total price
    for section, sectionPrdts in sections.items():
        print(section)
        for sectionPrdt in sectionPrdts:
            name = sectionPrdt[NOME]
            iva = sectionPrdt[TAXA]
            amount = sectionPrdt[-1]

            # Calculate the price without tax and only tax and both
            precoBruto = sectionPrdt[PRECO_BASE] * amount
            precoTaxa = precoBruto * sectionPrdt[TAXA]
            precoTotal = precoBruto + precoTaxa

            # Update the totals
            totalBruto += precoBruto
            totalIva += precoTaxa
            totalLiquido += precoTotal

            print(f"{amount:4d} {name:30s} ({iva:>3.0%}) {precoTotal:10.2f}")

    # Print the total prices at the end
    print(f"{'Total Bruto':>40s}: {totalBruto:10.2f}")
    print(f"{'Total IVA':>40s}: {totalIva:10.2f}")
    print(f"{'Total Liquido':>40s}: {totalLiquido:10.2f}")


def main(args):
    # produtos guarda a informação da base de dados numa forma conveniente.
    produtos = {"p1": ("Ketchup.", "Mercearia Salgado", 1.59, 0.23)}
    # Carregar base de dados principal
    loadDataBase("produtos.txt", produtos)
    # Juntar bases de dados opcionais (Não altere)
    for arg in args:
        loadDataBase(arg, produtos)

    # compras guarda os registos de uma compra
    compras = []

    # Use este código para mostrar o menu e ler a opção repetidamente
    MENU = "(C)ompra (F)atura (S)air ? "
    repetir = True
    while repetir:
        # Utilizador introduz a opção com uma letra minúscula ou maiúscula
        op = input(MENU).upper()
        # Processar opção
        if op == "C":
            # Esta opção regista os produtos de uma compra
            compra = registaCompra(produtos)
            # Se a compra for vazia não é registada, isto é mais
            # conveniente para o utilizador, caso ele se tenha
            # enganado na opção
            if compra != {}:
                compras.append(compra)
            else:
                print("Compra vazia, não registrada")
        elif op == "S":
            # Esta opção termina o programa
            repetir = False
        elif op == "F":
            # Esta opção imprime a fatura de uma compra

            # Pedimos ao utilizador o número da compra, se este número for
            # inválido mostramos um erro e discartamos a operação
            try:
                # Pedimos ao utilizador o número da compra
                compraIdx = int(input("Numero compra? "))
                assert compraIdx > 0
                assert compraIdx <= len(compras)
            except:
                print("Numero compra inválido")
                continue

            # A lista de compras começa em 0 no entanto o número de compras
            # começa em 1, por isso precisamos de subtrair 1 ao número de
            # compras para obter o indíce na lista da compra.
            compra = compras[compraIdx - 1]
            fatura(produtos, compra)

    print("Obrigado!")


# Não altere este código / Do not change this code
import sys

if __name__ == "__main__":
    main(sys.argv[1:])
