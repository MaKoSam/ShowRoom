package resources;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class planeTest {
	Plane plane = new Plane("123","beta",999,10.1);
	Plane plane2 = plane;
	Plane plane3 = new Plane("321","beta",999,10.1);
	@Test
	void test() {
		assertEquals(plane.getNumber(),"123");
		assertEquals(plane.getType(),"beta");
		assertEquals(plane.getSeats(),999);
		assertEquals(plane.age(),10.1);
		assertEquals(plane.equals(plane2),true);
		assertEquals(plane.equals(plane3),false);
		assertEquals(plane.hashCode(),plane2.hashCode());
	}

}
