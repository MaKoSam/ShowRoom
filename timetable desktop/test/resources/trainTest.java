package resources;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class trainTest {
	Train train = new Train("T101","alpha",114514);
	Train train2 = train;
	Train train3 = new Train("111","222",114514);
	@Test
	void test() {
		assertEquals(train.getNumber(),"T101");
		assertEquals(train.getType(),"alpha");
		assertEquals(train.getSeats(),114514);
		assertEquals(train.equals(train2),true);
		assertEquals(train.equals(train3),false);
		assertEquals(train.hashCode(),train2.hashCode());
	}

}