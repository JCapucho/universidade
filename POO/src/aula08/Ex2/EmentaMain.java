package aula08.Ex2;

import utils.UserInput;

import java.util.List;
import java.util.Vector;

/// Exercício opcional 8.3
public class EmentaMain {
    private static Vector<Alimento> alimentos = new Vector<>();
    private static Vector<Prato> pratos = new Vector<>();
    private static Ementa ementa = new Ementa("Ementa", "POO");

    public static void main(String[] args) {
        while (true) {
            int sel = UserInput.menuSelection(
                    "1: Ingredientes",
                    "2: Pratos",
                    "3: Ementa",
                    "0: Sair"
            );

            switch (sel) {
                case 1 -> {
                    menuIngredientes();
                }
                case 2 -> {
                    menuPratos();
                }
                case 3 -> {
                    menuEmenta();
                }
                case 0 -> {
                    return;
                }
            }
        }
    }

    private static void menuIngredientes() {
        while (true) {
            int sel = UserInput.menuSelection(
                    "1: Adicionar Carne",
                    "2: Adicionar Peixe",
                    "3: Adicionar Cereal",
                    "4: Adicionar Legume",
                    "0: Voltar"
            );

            if (sel == 0) return;

            double proteinas = UserInput.promptDoubleMin("Insira as proteínas: ", 0);
            double calorias = UserInput.promptDoubleMin("Insira as calorias: ", 0);
            double peso = UserInput.promptDoubleMin("Insira o peso: ", 0, true);

            int newIdx = alimentos.size();
            switch (sel) {
                case 1 -> {
                    VariedadeCarne variedade = UserInput.enumSelection(VariedadeCarne.class);

                    alimentos.add(new Carne(variedade, proteinas, calorias, peso));
                }
                case 2 -> {
                    TipoPeixe tipo = UserInput.enumSelection(TipoPeixe.class);

                    alimentos.add(new Peixe(tipo, proteinas, calorias, peso));
                }
                case 3 -> {
                    String nome = UserInput.prompt("Insira o nome do cereal: ");

                    alimentos.add(new Cereal(nome, proteinas, calorias, peso));
                }
                case 4 -> {
                    String nome = UserInput.prompt("Insira o nome do legume: ");

                    alimentos.add(new Legume(nome, proteinas, calorias, peso));
                }
            }

            System.out.printf("Novo ingrediente no indíce %d\n", newIdx);
        }
    }

    private static void menuPratos() {
        Prato selecionado = null;

        while (true) {
            int sel = UserInput.menuSelection(
                    "1: Criar prato",
                    "2: Apagar prato",
                    "3: Selecionar prato",
                    "4: Adicionar ingrediente",
                    "5: Remover ingrediente",
                    "0: Voltar"
            );

            switch (sel) {
                case 1 -> {
                    String nome = UserInput.prompt("Insira o nome do prato: ");
                    double preco = UserInput.promptDoubleMin("Insira o preço do prato: ", 0);

                    int newIdx = pratos.size();
                    selecionado = new Prato(nome, preco);
                    pratos.add(selecionado);
                    System.out.printf("Novo prato no indíce %d\n", newIdx);

                    System.out.printf("%s - Selecionado\n", selecionado);
                }
                case 2 -> {
                    if (selecionado == null) {
                        System.out.println("Nenhum prato selecionado");
                        continue;
                    }

                    pratos.remove(selecionado);
                    selecionado = null;
                }
                case 3 -> {
                    Prato prato = escolherPrato();
                    System.out.println(prato);
                    selecionado = prato;
                }
                case 4 -> {
                    if (selecionado == null) {
                        System.out.println("Nenhum prato selecionado");
                        continue;
                    }

                    Alimento ingrediente = escolherIngrediente();

                    if (ingrediente == null)
                        continue;

                    selecionado.addIngrediente(ingrediente);
                }
                case 5 -> {
                    if (selecionado == null) {
                        System.out.println("Nenhum prato selecionado");
                        continue;
                    }

                    List<Alimento> ingredientes = selecionado.alimentos();

                    int ingIdx = UserInput.promptIntRange("Escolhe o ingrediente: ", 0, ingredientes.size() - 1);

                    selecionado.removerIngrediente(ingIdx);
                }
                case 0 -> {
                    return;
                }
            }
        }
    }

    private static Alimento escolherIngrediente() {
        while (true) {
            int sel = UserInput.menuSelection(
                    "1: Escolher por indíce",
                    "0: Voltar"
            );

            switch (sel) {
                case 1 -> {
                    int ingredienteIdx = UserInput.promptIntMin("Escolhe o ingrediente: ", 0);

                    if (ingredienteIdx < alimentos.size())
                        return alimentos.get(ingredienteIdx);

                    System.out.println("Nenhum ingrediente encontrado");
                }
                case 0 -> {
                    return null;
                }
            }
        }
    }

    private static Prato escolherPrato() {
        while (true) {
            int sel = UserInput.menuSelection(
                    "1: Escolher por nome",
                    "2: Escolher por indíce",
                    "0: Voltar"
            );

            switch (sel) {
                case 1 -> {
                    Vector<Prato> candidatos = new Vector<>();
                    String nome = UserInput.prompt("Insira o nome do prato: ");

                    for (Prato prato : pratos) {
                        if (prato.getNome().contains(nome))
                            candidatos.add(prato);
                    }

                    if (candidatos.size() == 1) {
                        return candidatos.get(0);
                    } else if (candidatos.size() > 1) {
                        for (int i = 0; i < candidatos.size(); i++) {
                            Prato candidato = candidatos.get(i);
                            System.out.printf("%d: %s\n", i, candidato);
                        }

                        int candidatoIdx = UserInput.promptIntRange("Escolhe o prato: ", 0, candidatos.size() - 1);

                        return candidatos.get(candidatoIdx);
                    }
                }
                case 2 -> {
                    int pratoIdx = UserInput.promptIntMin("Escolhe o prato: ", 0);

                    if (pratoIdx < pratos.size())
                        return pratos.get(pratoIdx);
                }
                case 0 -> {
                    return null;
                }
            }

            System.out.println("Nenhum prato encontrado");
        }
    }

    private static void menuEmenta() {
        while (true) {
            int sel = UserInput.menuSelection(
                    "1: Adicionar prato",
                    "2: Remover prato",
                    "3: Imprimir ementa",
                    "0: Voltar"
            );

            switch (sel) {
                case 1 -> {
                    Prato prato = escolherPrato();
                    DiaSemana dia = UserInput.enumSelection(DiaSemana.class);

                    ementa.addPrato(prato, dia);
                }
                case 2 -> {
                    DiaSemana dia = UserInput.enumSelection(DiaSemana.class);

                    ementa.removePrato(dia);
                }
                case 3 -> {
                    System.out.println(ementa);
                }
                case 0 -> {
                    return;
                }
            }
        }
    }
}
