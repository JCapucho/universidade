package aula04;

import utils.UserInputValidationException;

import java.util.Arrays;
import java.util.Scanner;

class Car {
    public String make;
    public String model;
    public int year;
    public int kms;

    public Car(String make, String model, int year, int kms) {
        this.make = make;
        this.model = model;
        this.year = year;
        this.kms = kms;
    }

    public void drive(int distance) {
        kms += distance;
    }

}

public class CarDemo {

    static Scanner sc = new Scanner(System.in);

    static boolean isValidYear(String yearStr) {
        return yearStr.matches("[0-9]{4}");
    }

    static boolean isValidKms(String kmsStr) {
        return kmsStr.matches("[0-9]+");
    }

    static Car tryPromptCar() throws UserInputValidationException {
        System.out.print("Insira dados do carro (marca modelo ano quilómetros): ");
        String input = sc.nextLine();

        // registo de carros termina quando o utilizador inserir uma linha vazia
        if (input.trim().equals(""))
            return null;

        String[] comps = input.split("( )+");

        if (comps.length < 4)
            throw new UserInputValidationException("A linha tem que ter o formato: marca modelo ano quilómetros");

        String marca = comps[0];
        String anoStr = comps[comps.length - 2];
        String kmsStr = comps[comps.length - 1];

        if (!isValidYear(anoStr))
            throw new UserInputValidationException("O ano têm que estar no formato yyyy");

        if (!isValidKms(kmsStr))
            throw new UserInputValidationException("Os kilometros só podem conter números");

        Integer ano = Integer.parseInt(anoStr);
        Integer kms = Integer.parseInt(kmsStr);

        String[] modeloComps = Arrays.copyOfRange(comps, 1, comps.length - 2);
        String modelo = String.join(" ", modeloComps);

        return new Car(marca, modelo, ano, kms);
    }

    static Car promptCar() {
        while (true) {
            try {
                return tryPromptCar();
            } catch (UserInputValidationException e) {
                System.out.printf("Erro: %s\n", e.getMessage());
            }
        }
    }

    static int registerCars(Car[] cars) {
        int numCars = 0;
        for (; numCars < 10; numCars++) {
            Car car = promptCar();

            if (car == null)
                break;

            cars[numCars] = car;
            System.out.printf("Carro %d inserido\n", numCars);
        }

        // devolve número de carros registados
        return numCars;
    }

    static boolean tryRegisterTrip(Car[] cars, int numCars) throws UserInputValidationException {
        System.out.print("Registe uma viagem no formato \"carro:distância\": ");
        String input = sc.nextLine();

        // registo de viagens termina quando o utilizador inserir uma linha vazia
        if (input.trim().equals(""))
            return true;

        String[] comps = input.split(":");

        if (comps.length != 2)
            throw new UserInputValidationException("A linha tem que ter o formato: carro:distância");

        String carroStr = comps[0];
        String distStr = comps[1];

        if (!carroStr.matches("[0-9]+"))
            throw new UserInputValidationException("O número do carro têm que ser um natural");

        if (!distStr.matches("[0-9]+"))
            throw new UserInputValidationException("A distância têm que ser um natural");

        Integer carro = Integer.parseInt(carroStr);
        Integer dist = Integer.parseInt(distStr);

        if (carro >= numCars)
            throw new UserInputValidationException("Carro não registado");

        cars[carro].drive(dist);

        return false;
    }

    static void registerTrips(Car[] cars, int numCars) {
        while (true) {
            try {
                boolean finished = tryRegisterTrip(cars, numCars);

                if (finished) break;
            } catch (UserInputValidationException e) {
                System.out.printf("Erro: %s\n", e.getMessage());
            }
        }
    }


    static void listCars(Car[] cars) {
        System.out.println("\nCarros registados: ");
        // Exemplo de resultado
        // Carros registados: 
        // Toyota Camry, 2010, kms: 234346
        // Renault Megane Sport Tourer, 2015, kms: 32536
        for (Car car : cars) {
            // Como o vetor é criado com tamanho fixo, todos os valores
            // são inicializados a null, como nós preemchemos o array sequencialmente
            // quando encontrarmos um null quer dizer que acabaram-se os elementos válidos
            if (car == null)
                break;

            System.out.printf("%s %s, %d, kms: %d\n", car.make, car.model, car.year, car.kms);
        }

        System.out.println("\n");
    }

    public static void main(String[] args) {

        Car[] cars = new Car[10];

        int numCars = registerCars(cars);

        if (numCars > 0) {
            listCars(cars);
            registerTrips(cars, numCars);
            listCars(cars);
        }

        sc.close();

    }
}