package aula07;

import utils.InputValidator;
import utils.UserInput;

import java.util.ArrayList;

public class Ex01 {
    private static ArrayList<Forma> formas = new ArrayList();

    public static void main(String[] args) {
        while (true) {
            System.out.println(" 1) Criar círculo");
            System.out.println(" 2) Criar triângulo");
            System.out.println(" 3) Criar retângulo");
            System.out.println(" 4) Imprimir forma");
            System.out.println(" 5) Comparar formas");
            System.out.println(" 6) Modificar forma");
            System.out.println(" 7) Área da forma");
            System.out.println(" 8) Perímetro da forma");
            System.out.println(" 9) Hash da forma");
            System.out.println("10) Sair");

            int selection = UserInput.promptIntRange("Insira a sua seleção: ", 1, 10);

            switch (selection) {
                case 1 -> {
                    String cor = promptCor();
                    double raio = UserInput.promptDoubleMin("Insira o raio: ", 0, true);
                    try {
                        addForma(new Círculo(cor, raio));
                    } catch (AssertionError e) {
                        System.out.println("Valores inválidos");
                    }
                }
                case 2 -> {
                    String cor = promptCor();
                    double lado1 = UserInput.promptDoubleMin("Insira o primeiro lado: ", 0, true);
                    double lado2 = UserInput.promptDoubleMin("Insira o segundo lado: ", 0, true);
                    double lado3 = UserInput.promptDoubleMin("Insira o terceiro lado: ", 0, true);
                    try {
                        addForma(new Triângulo(cor, lado1, lado2, lado3));
                    } catch (AssertionError e) {
                        System.out.println("Valores inválidos");
                    }
                }
                case 3 -> {
                    String cor = promptCor();
                    double comprimento = UserInput.promptDoubleMin("Insira o comprimento: ", 0, true);
                    double altura = UserInput.promptDoubleMin("Insira a altura: ", 0, true);
                    try {
                        addForma(new Retângulo(cor, comprimento, altura));
                    } catch (AssertionError e) {
                        System.out.println("Valores inválidos");
                    }
                }
                case 4 -> {
                    if (formas.size() == 0) {
                        System.out.println("Insira primeiro uma forma");
                        continue;
                    }

                    Object forma = promptForma("Insira o indíce da forma: ");
                    System.out.println(forma);
                }
                case 5 -> {
                    if (formas.size() == 0) {
                        System.out.println("Insira primeiro uma forma");
                        continue;
                    }

                    Object forma1 = promptForma("Insira o indíce da primeira forma: ");
                    Object forma2 = promptForma("Insira o indíce da segunda forma: ");
                    System.out.println(forma1.equals(forma2));
                }
                case 6 -> {
                    if (formas.size() == 0) {
                        System.out.println("Insira primeiro uma forma");
                        continue;
                    }

                    Forma forma = promptForma("Insira o indíce da forma: ");

                    try {
                        String cor = promptCor();

                        forma.setCor(cor);

                        if (forma instanceof Círculo) {
                            Círculo círculo = ((Círculo) forma);
                            double raio = UserInput.promptDoubleMin("Insira o raio: ", 0, true);
                            círculo.setRaio(raio);
                        } else if (forma instanceof Triângulo) {
                            Triângulo triângulo = ((Triângulo) forma);
                            double lado1 = UserInput.promptDoubleMin("Insira o primeiro lado: ", 0, true);
                            double lado2 = UserInput.promptDoubleMin("Insira o segundo lado: ", 0, true);
                            double lado3 = UserInput.promptDoubleMin("Insira o terceiro lado: ", 0, true);
                            triângulo.setLado1(lado1);
                            triângulo.setLado2(lado2);
                            triângulo.setLado3(lado3);
                        } else if (forma instanceof Retângulo) {
                            Retângulo retângulo = ((Retângulo) forma);
                            double comprimento = UserInput.promptDoubleMin("Insira o comprimento: ", 0, true);
                            double altura = UserInput.promptDoubleMin("Insira a altura: ", 0, true);
                            retângulo.setComprimento(comprimento);
                            retângulo.setAltura(altura);
                        }
                    } catch (AssertionError e) {
                        System.out.println("Valores inválidos");
                    }
                }
                case 7 -> {
                    if (formas.size() == 0) {
                        System.out.println("Insira primeiro uma forma");
                        continue;
                    }

                    Forma forma = promptForma("Insira o indíce da forma: ");
                    System.out.printf("A área da forma é: %f\n", forma.area());
                }
                case 8 -> {
                    if (formas.size() == 0) {
                        System.out.println("Insira primeiro uma forma");
                        continue;
                    }

                    Forma forma = promptForma("Insira o indíce da forma: ");
                    System.out.printf("O perímetro da forma é: %f\n", forma.perimetro());
                }
                case 9 -> {
                    if (formas.size() == 0) {
                        System.out.println("Insira primeiro uma forma");
                        continue;
                    }

                    Object forma = promptForma("Insira o indíce da forma: ");
                    System.out.printf("A hash da forma é: %d\n", forma.hashCode());
                }
                case 10 -> {
                    System.out.println("Bom dia!");
                    return;
                }
            }

            System.out.println();
        }
    }

    private static Forma promptForma(String prompt) {
        int index = UserInput.promptIntRange(prompt, 0, formas.size() - 1);
        return formas.get(index);
    }

    private static void addForma(Forma o) {
        int index = formas.size();
        formas.add(o);
        System.out.printf("Forma inserida no indíce %d\n", index);
    }

    private static String promptCor() {
        return UserInput.promptValidator(
                "Insira a cor da forma: ",
                InputValidator.functional(v -> v.length() != 0, "A cor não pode ser vazia")
        );
    }
}
