package aula09;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class PlaneManager {
    private Map<String, Plane> planes = new HashMap<>();

    public void addPlane(Plane plane) {
        this.planes.put(plane.getId(), plane);
    }

    public void removePlane(String id) {
        this.planes.remove(id);
    }

    public Plane searchPlane(String id) {
        return this.planes.get(id);
    }

    public List<Plane> getCommercialPlanes() {
        return this.planes.values().stream().filter(plane -> plane.getPlaneType().equals(CommercialPlane.PLANE_TYPE))
                .collect(Collectors.toList());
    }

    public List<Plane> getMilitarPlanes() {
        return this.planes.values().stream().filter(plane -> plane.getPlaneType().equals(MilitaryPlane.PLANE_TYPE))
                .collect(Collectors.toList());
    }

    public void printAllPlanes() {
        for (Plane plane : this.planes.values())
            System.out.println(plane);
    }

    public Plane getFastestPlane() {
        return Collections.max(this.planes.values(),
                (plane1, plane2) -> Integer.compare(plane1.getVelocidadeMaxima(), plane2.getVelocidadeMaxima()));
    }
}
