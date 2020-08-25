//MARK: - Planning Entry Subclass
package planningentry;

//MARK: - Lib's
import java.util.Arrays;
import java.util.Objects;
import java.time.*;

//MARK: - Packages
import Property.*;

public class StudySchedule<R> extends CommonPlanningEntry<R> {

	//MARK: - Properties
	private int resourceID;
	
	//MARK: - Init
	StudySchedule(Location location, TimeSlot timeslot, String planningEntryNumber) {
		this.location 			 = location;
		this.timeslot 			 = timeslot;
		this.planningEntryNumber = planningEntryNumber;
		this.state 				 = new EntryState(WAITING);
		this.planningEntryType 	 = "Study";
	}
	
	public Boolean allocateResources(@SuppressWarnings("unchecked") R... resources) {
		this.resources.addAll(Arrays.asList(resources));
		resourceID = this.resources.size();
		return this.state.setNewState(strPlanningEntryType, ALLOCATED);
	}

	public LocalDateTime getBeginningTime() {
		return timeslot.getDepartureTime().get(0);
	}

	public LocalDateTime getEndingTime() {
		return timeslot.getArrivalTime().get(0);
	}
	
	public int getResourceID() {
		return this.resourceID;
	}

	public String getStrLocation() {
		return location.getLocations().get(0);
	}

	@Override public String toString() {
		return "Resource ID: " + getResourceID();
	}

	//MARK: - CheckRep
	boolean checkRep() {
		return this instanceof StudySchedule && this.planningEntryType == "Study" ? true : false;
	}

	@Override public boolean equals(Object o) {
		if (o == this) {
			return true;
		}

		if (!(o instanceof StudySchedule)) {
			return false;
		}

		@SuppressWarnings("unchecked")
		StudySchedule<R> tmp = (StudySchedule<R>) o;
		return resourceID == tmp.resourceID &&
							 this.getLocation().equals(tmp.getLocation()) &&
							 this.getState().getStrState().contentEquals(tmp.getState().getStrState());
	}

	@Override public int hashCode() {
		return Objects.hashCode(resourceID);
	}
}
