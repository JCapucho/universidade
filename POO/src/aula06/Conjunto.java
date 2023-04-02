package aula06;

import java.util.Vector;

public class Conjunto {
    private Vector<Integer> data = new Vector<>();

    public void insert(int n) {
        if (this.data.contains(n)) return;

        this.data.add(n);
    }

    public boolean contains(int n) {
        for (int num : this.data) {
            if (n == num) return true;
        }

        return false;
    }

    public void remove(int n) {
        this.data.removeElement(n);
    }

    public void empty() {
        this.data.clear();
    }

    public int size() {
        return this.data.size();
    }

    public Conjunto combine(Conjunto add) {
        Conjunto union = (Conjunto) this.clone();

        for (int n : add.data)
            union.insert(n);

        return union;
    }

    public Conjunto subtract(Conjunto dif) {
        Conjunto subtracted = (Conjunto) this.clone();

        for (int n : dif.data)
            subtracted.remove(n);

        return subtracted;
    }


    public Conjunto intersect(Conjunto inter) {
        Conjunto intersected = new Conjunto();

        for (int n : this.data) {
            if (inter.contains(n))
                intersected.insert(n);
        }

        return intersected;
    }

    @Override
    protected Object clone() {
        Conjunto union = new Conjunto();
        union.data = (Vector<Integer>) this.data.clone();
        return union;
    }

    @Override
    public String toString() {
        String accum = "";

        for (int i = 0; i < this.data.size(); i++) {
            if (i != 0) accum += " ";

            accum += this.data.get(i);
        }

        return accum;
    }
}
