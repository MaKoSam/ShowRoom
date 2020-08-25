package planningentry;
import resources.*;
import info.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;

class flightScheduleTest {
	Location location = new Location("Yantai","Harbin");
	List<String> ar = new ArrayList<>();
	List<String> le = new ArrayList<>();
	@Test
	void test() {
		ar.add("2000-02-27 10:27");
		le.add("2000-02-26 10:27");
		Timeslot timeslot = new Timeslot(ar,le);
		Plane plane = Resource.newResourceOfPlane("123", "alpha", 12, 5.2);
		FlightSchedule<Resource> f = PlanningEntry.newFlightSchedule(location,timeslot,"1");
		FlightSchedule<Resource> f3 = PlanningEntry.newFlightSchedule(location, timeslot, "1");
		assertEquals(f.getLocationOrigin(), "Yantai");
		assertEquals(f.getLocationTerminal(), "Harbin");
		assertEquals(f.getState().getStrState(),"WAITING");
		f.allocateResource(plane);
		assertEquals(f.getState().getStrState(),"ALLOCATED");
		assertEquals(f.cancel(),true);
		assertEquals(f.getState().getStrState(),"CANCELLED");
		FlightSchedule<Resource> f2 = f;
		assertEquals(f.equals(f2),true);
		assertEquals(false,f.equals(f3));
	}

}
