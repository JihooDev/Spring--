package appTest;

import static org.junit.Assert.*;

import org.junit.Test;


public class CarTest {
	Car c1 = new Car("소나타", "red", 1230);
	Car c2 = new Car("소나타", "reds", 1230);

	@Test
	public void testMethod3() {
		Car[] car1 = new Car[2];
		Car[] car2 = new Car[2];
		
		car1[0] = new Car("쉐보레","blue",23000);
		car1[1] = new Car("아반떼","red",23000);
		car2[0] = new Car("벤츠","green",3000);
		car2[1] = new Car("bmw","green",5000);
		
		assertArrayEquals(car1, car2);
	}
	
	@Test
	public void testMethod2() {
		
		c1 = c2;
		
		assertSame(c1, c2);
	}
	
	@Test
	public void testMethod1() {
		assertEquals(c1.color, c2.color);
	}
	
	
}

class Car {
	String name;
	String color;
	int price;
	
	Car(String name, String color, int price){
		this.name = name;
		this.color = color;
		this.price = price;
	}
}



