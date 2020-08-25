package planningentry;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;

import info.Location;
import info.Timeslot;
import resources.Resource;
import resources.Document;

class studyScheduleTest {
	Location location = new Location("B01");
	List<String> ar = new ArrayList<>();
	List<String> le = new ArrayList<>();
	@Test
	void test() {
		ar.add("2000-02-27 10:27");
		le.add("2000-02-27 10:27");
		Timeslot timeslot = new Timeslot(ar,le);
		Document doc = Resource.newResourceOfDoc("Java", "Cay", "2000-02-26");
		Document doc2 = Resource.newResourceOfDoc("C++", "?", "1999-03-04");
		StudySchedule<Resource> f = PlanningEntry.newStudySchedule(location,timeslot,"1");
		StudySchedule<Resource> f3 = PlanningEntry.newStudySchedule(location, timeslot, "1");
		assertEquals(f.getStrLocation(), "B01");
		assertEquals(f.getState().getStrState(),"WAITING");
		f.allocateResources(doc,doc2);
		assertEquals(f.getState().getStrState(),"ALLOCATED");
		assertEquals(f.start(),true);
		assertEquals(f.getState().getStrState(),"RUNNING");
		assertEquals(f.end(),true);
		assertEquals(f.getState().getStrState(),"ENDED");
		StudySchedule<Resource> f2 = f;
		assertEquals(f.equals(f2),true);
		assertEquals(false,f.equals(f3));
	}
}
