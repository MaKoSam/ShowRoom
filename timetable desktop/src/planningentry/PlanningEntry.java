//MARK: - Planning Entry Super class
package planningentry;

//MARK: - Lib's
import java.util.*;

//MARK: - Packages
import Properties.*;

public interface PlanningEntry <R> {
	//MARK: - Class is super flexible and 
	// 			can handle any activity set
	
	//MARK: - Flight Init
	public static <R> FlightSchedule <R> newFlightSchedule(Location location,
														   TimeSlot timeslot, 
														   String planningEntryNumber) {
		return new FlightSchedule <R> (location, timeslot, planningEntryNumber);
	}
	
	//MARK: - Train Init
	public static <R> TrainSchedule <R> newTrainSchedule(Location location,
														 TimeSlot timeslot, 
														 String planningEntryNumber) {
		return new TrainSchedule <R> (location, timeslot, planningEntryNumber);
	}
	
	//MARK: - Study Init
	public static <R> StudySchedule <R> newStudySchedule(Location location,
														 TimeSlot timeslot, 
														 String planningEntryNumber) {
		return new StudySchedule <R>(location, timeslot, planningEntryNumber);
	}

	private void checkRepFlight() {
    	assert (planningEntryType.equals("FlightSchedule"));
    	assert (location != null);
    	assert (timeSlot != null);
    	assert (state 	 != null);
    	assert (resource != null);
	}

	private void checkRepTrain() {
    	assert (planningEntryType.equals("TrainSchedule"));
    	assert (location != null);
    	assert (timeSlot != null);
    	assert (state 	 != null);
    	assert (resource != null);
	}

	private void checkRepStudy() {
    	assert (planningEntryType.equals("StudySchedule"));
    	assert (location != null);
    	assert (timeSlot != null);
    	assert (state    != null);
    	assert (resource != null);
	}

	
	public Boolean start();
	public Boolean block();
	public Boolean cancel();	
	public Boolean end();
	
	public Location getLocation();
	public TimeSlot getTimeslot();	
	public EntryState getState();	
	public String getPlanningEntryType();
	public List <R> getResources();
	public String getPlanningEntryNumber();
}