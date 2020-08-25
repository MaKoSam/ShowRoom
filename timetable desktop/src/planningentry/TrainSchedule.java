//MARK: - Planning Entry Subclass
package planningentry;

//MARK: - Lib's
import java.util.Arrays;
import java.util.Objects;
import java.time.*;

//MARK: - Packages
import Property.*;

public class TrainSchedule<R> extends CommonPlanningEntry<R> {

	//MARK: - Properties
	public int ORIGIN,
			   LENGTH,
			   TERMINAL;
	
	//MARK: - Init
	TrainSchedule(Location location, TimeSlot timeslot, String planningEntryNumber) {
		this.location 			  = location;
		this.timeslot 			  = timeslot;
		this.planningEntryNumber  = planningEntryNumber;
		this.state 				  = new EntryState(WAITING);
		this.strPlanningEntryType = "Train";
	}
	
	public Boolean allocateResources(@SuppressWarnings("unchecked") R... resources) {
		this.resources.addAll(Arrays.asList(resources));
		this.ORIGIN 	= 0;
		this.LENGTH 	= this.resources.size();
		this.TERMINAL 	= this.resources.size() - 1;
		return this.state.setNewState(strPlanningEntryType, ALLOCATED);
	}

	public LocalDateTime getArrivalTimeOfIndex(int index) {
		return timeslot.getArrivalTime().get(index);
	}
	
	public LocalDateTime getLeavingTimeOfIndex(int index) {
		return timeslot.getDepartureTime().get(index);
	}
	
	public String getLocationOfIndex(int index) {
		return location.getLocations().get(index);
	}

	boolean checkRep() {
		return this instanceof TrainSchedule && this.planningEntryType == "Train" ? true : false;
	}

	@Override public boolean equals(Object o) {
		if (o == this) {
			return true;
		}

		if (!(o instanceof FlightSchedule)) {
			return false;
		}

		@SuppressWarnings("unchecked")
		FlightSchedule<R> tmp = (FlightSchedule<R>) o;
		return this.getResources().equals(tmp.getResources()) &&
			   this.getLocation().equals(tmp.getLocation()) &&
			   this.getState().getStrState().contentEquals(tmp.getState().getStrState());
	}

	@Override public int hashCode() {
		return Objects.hashCode(getResources());
	}
}
