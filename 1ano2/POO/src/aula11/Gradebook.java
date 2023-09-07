package aula11;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.*;

public class Gradebook {
    // Keep them sorted for printing
    final Map<String, Student> students = new TreeMap<>();
    final IGradeCalculator calculator = new SimpleGradeCalculator();

    public void load(String path) throws FileNotFoundException {
        final Scanner input = new Scanner(new FileReader(path));

        input.useDelimiter("(\\||[\\r\\n]+)");

        while (input.hasNext()) {
            String nome = input.next();
            double nota1 = input.nextDouble();
            double nota2 = input.nextDouble();
            double nota3 = input.nextDouble();

            List<Double> grades = Arrays.asList(nota1, nota2, nota3);
            students.put(nome, new Student(nome, grades));

            input.nextLine();
        }

        input.close();
    }

    public void addStudent(Student student) {
        students.put(student.getName(), student);
    }

    public void removeStudent(String name) {
        students.remove(name);
    }

    public Student getStudent(String name) {
        return students.get(name);
    }

    public double calculateAverageGrade(String name) {
        Student student = getStudent(name);
        return studentAverage(student);
    }

    private double studentAverage(Student student) {
        return calculator.calculate(student.getGrades());
    }

    public void printAllStudents() {
        for (Student student : students.values()) {
            System.out.println(student.getName() + ", grades=" + student.getGrades() + ", average=" + studentAverage(student));
        }
    }
}
