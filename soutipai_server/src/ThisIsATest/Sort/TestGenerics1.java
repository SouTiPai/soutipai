package ThisIsATest.Sort;

import java.util.ArrayList;

public class TestGenerics1 {
    public static void main(String[] args) {
        new TestGenerics1().go();
    }

    public void go(){
        ArrayList<Animal> animals = new ArrayList<>();
        animals.add(new Dog());
        animals.add(new Cat());
        animals.add(new Dog());
        takeAnimals(animals);

        ArrayList<Dog> dogs = new ArrayList<>();
        dogs.add(new Dog());
        dogs.add(new Dog());
        takeAnimals(dogs);
    }

    public void takeAnimals(ArrayList<? extends Animal> animals){
        for (Animal a: animals){
            a.eat();
        }
    }
}
