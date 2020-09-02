package Properties;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class locationTest {
	Location loc = new Location("1","2","3");
	Location loc2 = new Location("1","2","3");
	Location loc3 = new Location("1","2");
	@Test
	void test() {
		assertEquals(loc.getLocations().get(0),"1");
		assertEquals(loc.getLocations().get(1),"2");
		assertEquals(loc.getLocations().get(2),"3");
		assertEquals(loc.equals(loc2),true);
		assertEquals(loc.equals(loc3),false);
		assertEquals(loc.hashCode(),loc2.hashCode());
	}

}
