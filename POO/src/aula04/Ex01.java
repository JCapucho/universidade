package aula04;

import utils.UserInput;

import java.util.ArrayList;
import java.util.Objects;

public class Ex01 {
    private static ArrayList<Figura> figuras = new ArrayList();

    public static void main(String[] args) {
        while (true) {
            System.out.println(" 1) Criar círculo");
            System.out.println(" 2) Criar triângulo");
            System.out.println(" 3) Criar retângulo");
            System.out.println(" 4) Imprimir figura");
            System.out.println(" 5) Comparar figuras");
            System.out.println(" 6) Modificar figura");
            System.out.println(" 7) Área da figura");
            System.out.println(" 8) Perímetro da figura");
            System.out.println(" 9) Hash da figura");
            System.out.println("10) Sair");

            int selection = UserInput.promptIntRange("Insira a sua seleção: ", 1, 10);

            switch (selection) {
                case 1 -> {
                    double raio = UserInput.promptDoubleMin("Insira o raio: ", 0, true);
                    try {
                        addFigura(new Círculo(raio));
                    } catch (AssertionError e) {
                        System.out.println("Valores inválidos");
                    }
                }
                case 2 -> {
                    double lado1 = UserInput.promptDoubleMin("Insira o primeiro lado: ", 0, true);
                    double lado2 = UserInput.promptDoubleMin("Insira o segundo lado: ", 0, true);
                    double lado3 = UserInput.promptDoubleMin("Insira o terceiro lado: ", 0, true);
                    try {
                        addFigura(new Triângulo(lado1, lado2, lado3));
                    } catch (AssertionError e) {
                        System.out.println("Valores inválidos");
                    }
                }
                case 3 -> {
                    double comprimento = UserInput.promptDoubleMin("Insira o comprimento: ", 0, true);
                    double altura = UserInput.promptDoubleMin("Insira a altura: ", 0, true);
                    try {
                        addFigura(new Retângulo(comprimento, altura));
                    } catch (AssertionError e) {
                        System.out.println("Valores inválidos");
                    }
                }
                case 4 -> {
                    Object figura = promptFigura("Insira o indíce da figura: ");
                    System.out.println(figura);
                }
                case 5 -> {
                    Object figura1 = promptFigura("Insira o indíce da primeira figura: ");
                    Object figura2 = promptFigura("Insira o indíce da segunda figura: ");
                    System.out.println(figura1.equals(figura2));
                }
                case 6 -> {
                    Object figura = promptFigura("Insira o indíce da figura: ");

                    try {
                        if (figura instanceof Círculo) {
                            Círculo círculo = ((Círculo) figura);
                            double raio = UserInput.promptDoubleMin("Insira o raio: ", 0, true);
                            círculo.setRaio(raio);
                        } else if (figura instanceof Triângulo) {
                            Triângulo triângulo = ((Triângulo) figura);
                            double lado1 = UserInput.promptDoubleMin("Insira o primeiro lado: ", 0, true);
                            double lado2 = UserInput.promptDoubleMin("Insira o segundo lado: ", 0, true);
                            double lado3 = UserInput.promptDoubleMin("Insira o terceiro lado: ", 0, true);
                            triângulo.setLado1(lado1);
                            triângulo.setLado2(lado2);
                            triângulo.setLado3(lado3);
                        } else if (figura instanceof Retângulo) {
                            Retângulo retângulo = ((Retângulo) figura);
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
                    Figura figura = promptFigura("Insira o indíce da figura: ");
                    System.out.printf("A área da figura é: %f\n", figura.area());
                }
                case 8 -> {
                    Figura figura = promptFigura("Insira o indíce da figura: ");
                    System.out.printf("O perímetro da figura é: %f\n", figura.perimetro());
                }
                case 9 -> {
                    Object figura = promptFigura("Insira o indíce da figura: ");
                    System.out.printf("A hash da figura é: %d\n", figura.hashCode());
                }
                case 10 -> {
                    System.out.println("Bom dia!");
                    return;
                }
            }

            System.out.println();
        }
    }

    private static Figura promptFigura(String prompt) {
        int index = UserInput.promptIntRange(prompt, 0, figuras.size() - 1);
        return figuras.get(index);
    }

    private static void addFigura(Figura o) {
        int index = figuras.size();
        figuras.add(o);
        System.out.printf("Figura inserida no indíce %d\n", index);
    }
}
