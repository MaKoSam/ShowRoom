package planningentry;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;

import info.Location;
import info.Timeslot;
import resources.Train;
import resources.Resource;

class trainScheduleTest {
	Location location = new Location("Yantai","Harbin","Xining");
	List<String> ar = new ArrayList<>();
	List<String> le = new ArrayList<>();
	@Test
	void test() {
		ar.add("2000-02-27 10:27");
		le.add("2000-02-27 10:27");
		ar.add("2000-02-28 10:27");
		le.add("2000-02-28 11:27");
		ar.add("2000-02-29 11:27");
		le.add("2000-02-29 11:27");
		Timeslot timeslot = new Timeslot(ar,le);
		Train train = Resource.newResourceOfTrain("123", "alpha", 12);
		Train train2 = Resource.newResourceOfTrain("123", "beta", 12);
		TrainSchedule<Resource> f = PlanningEntry.newTrainSchedule(location,timeslot,"1");
		FlightSchedule<Resource> f3 = PlanningEntry.newFlightSchedule(location, timeslot, "1");
		assertEquals(f.getLocationOfIndex(0), "Yantai");
		assertEquals(f.getLocationOfIndex(1), "Harbin");
		assertEquals(f.getLocationOfIndex(2), "Xining");
		assertEquals(f.getState().getStrState(),"WAITING");
		f.allocateResources(train,train2);
		assertEquals(f.getState().getStrState(),"ALLOCATED");
		assertEquals(f.start(),true);
		assertEquals(f.getState().getStrState(),"RUNNING");
		assertEquals(f.block(),true);
		assertEquals(f.getState().getStrState(),"BLOCKED");
		assertEquals(f.cancel(),true);
		assertEquals(f.getState().getStrState(),"CANCELLED");
		TrainSchedule<Resource> f2 = f;
		assertEquals(f.equals(f2),true);
		assertEquals(false,f.equals(f3));
	}

}
