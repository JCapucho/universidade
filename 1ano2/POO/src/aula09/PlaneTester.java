package aula09;

import utils.UserInput;

import java.util.Collection;

public class PlaneTester {
    private static PlaneManager frota = new PlaneManager();

    public static void main(String[] args) {
        while (true) {
            int sel = UserInput.menuSelection(
                    "1: Adicionar Avião",
                    "2: Remover Avião",
                    "3: Procurar avião",
                    "4: Aviões na frota",
                    "5: Aviões por tipo",
                    "6: Avião mais rápido",
                    "0: Sair"
            );

            switch (sel) {
                case 1 -> {
                    String id = UserInput.prompt("Identificador do avião: ");
                    String fabricante = UserInput.prompt("Fabricante do avião: ");
                    String modelo = UserInput.prompt("Modelo do avião: ");

                    int anoProducao = UserInput.promptInt("Ano de produção: ");
                    int numPassageiros = UserInput.promptIntMin("Número de passageiros: ", 0);
                    int velocidadeMaxima = UserInput.promptIntMin("Velocidade máxima: ", 0, true);

                    int tipo = UserInput.menuSelection(
                            "0: Avião comercial",
                            "1: Avião militar"
                    );

                    switch (tipo) {
                        case 0 -> {
                            int numTripulantes = UserInput.promptIntMin("Número de tripulantes: ", 0, true);
                            Plane plane = new CommercialPlane(id, fabricante, modelo, anoProducao, numPassageiros
                                    , velocidadeMaxima, numTripulantes);
                            frota.addPlane(plane);
                        }
                        case 1 -> {
                            int numMunicoes = UserInput.promptIntMin("Número de munições: ", 0);
                            Plane plane = new MilitaryPlane(id, fabricante, modelo, anoProducao, numPassageiros,
                                    velocidadeMaxima, numMunicoes);
                            frota.addPlane(plane);
                        }
                    }
                }
                case 2 -> {
                    String id = UserInput.prompt("Identificador do avião: ");
                    frota.removePlane(id);
                }
                case 3 -> {
                    String id = UserInput.prompt("Identificador do avião: ");
                    Plane plane = frota.searchPlane(id);

                    if (plane == null) {
                        System.out.println("Nenhum avião encontrado");
                        continue;
                    }

                    System.out.println(plane);
                }
                case 4 -> frota.printAllPlanes();
                case 5 -> {
                    Collection<Plane> planes = null;
                    int tipo = UserInput.menuSelection(
                            "0: Aviões Comerciais",
                            "1: Aviões Militares"
                    );

                    switch (tipo) {
                        case 0 -> planes = frota.getCommercialPlanes();
                        case 1 -> planes = frota.getMilitarPlanes();
                    }

                    if (planes == null) continue;

                    for (Plane plane : planes)
                        System.out.println(plane);
                }
                case 6 -> System.out.println(frota.getFastestPlane());
                case 0 -> {
                    return;
                }
            }
        }
    }
}
