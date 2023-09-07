package aula09;

public class CommercialPlane extends Plane {
    public static final String PLANE_TYPE = "Comercial";
    private int numTripulantes;

    public CommercialPlane(String id, String fabricante, String modelo, int anoProducao, int maxPassageiros,
                           int velocidadeMaxima, int numTripulantes) {
        super(id, fabricante, modelo, anoProducao, maxPassageiros, velocidadeMaxima);
        this.setNumTripulantes(numTripulantes);
    }


    public int getNumTripulantes() {
        return numTripulantes;
    }

    public void setNumTripulantes(int numTripulantes) {
        if (numTripulantes <= 0)
            throw new IllegalArgumentException("O número de tripulantes tem de ser positivo");

        this.numTripulantes = numTripulantes;
    }

    @Override
    public String getPlaneType() {
        return PLANE_TYPE;
    }

    @Override
    public String toString() {
        return "Commercial " + super.toString() + ", tripulantes: " + numTripulantes;
    }
}
