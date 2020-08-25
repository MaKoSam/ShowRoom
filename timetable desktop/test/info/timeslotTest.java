package Properties;

import static org.junit.jupiter.api.Assertions.*;

import java.util.*;
import java.time.*;
import java.time.format.DateTimeFormatter;

import org.junit.jupiter.api.Test;

class timeslotTest {
	List<String> ar = new ArrayList<>();
	List<String> le = new ArrayList<>();
	@Test
	void test() {
		ar.add("2000-02-27 10:27");
		le.add("2000-02-26 10:27");
		LocalDateTime arr = LocalDateTime.parse("2000-02-27 10:27",DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		LocalDateTime lev = LocalDateTime.parse("2000-02-26 10:27",DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		Timeslot timeslot = new Timeslot(ar,le);
		Timeslot timeslot2 = new Timeslot(ar,le);
		Timeslot timeslot3 = new Timeslot(le,ar);
		assertEquals(timeslot.getLeaving().get(0),lev);
		assertEquals(timeslot.getArrival().get(0),arr);
		assertEquals(timeslot.equals(timeslot2),true);
		assertEquals(timeslot.equals(timeslot3),false);
		assertEquals(timeslot.hashCode(),timeslot2.hashCode());
	}

}
