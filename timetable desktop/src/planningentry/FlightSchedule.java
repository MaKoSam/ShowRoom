//MARK: - Planning Entry - Subclass Common Entry
package planningentry;

//Lib's
import java.time.*;
import java.util.Objects;

//Packages
import Properties.*;

public class FlightSchedule <R> extends CommonPlanningEntry<R> {

	//MARK: - Properties
	static final int departureIndex = 0,
					 arrivalIndex = 1;
	
	//MARK: - Init
	FlightSchedule(Location location, TimeSlot timeSlot, String planningEntryNumber) {
		this.location 				= location;
		this.timeSlot 				= timeSlot;
		this.planningEntryNumber 	= planningEntryNumber;
		this.state 					= new EntryState("Waiting");
		this.planningEntryType 		= "Flight"; //MUST BE Double checked for passing wrong type
	}

	public String getDepartureLocation() {
		return this.getLocation().getLocations().get(departureIndex);
	}

	public String getArrivalLocation()	{
		return this.getLocation().getLocations().get(arrivalIndex);
	}
	
	public Boolean allocateResource(R resource) {
		this.resources.add(resource);
		return this.state.setNewState(strPlanningEntryType, "Allocated");
	}

	public LocalDateTime getArrivalTime() {
		return this.getTimeslot().getArrivalTime().get(0);
	}

	public LocalDateTime getDepartureTime() {
		return this.getTimeslot().getDepartureTime().get(0);
	}

	boolean checkRep() {
		return this instanceof FlightSchedule && this.planningEntryType == "Flight" ? true : false;
	}

	@Override public boolean equals(Object o) {
		if (o == this){
			return true;
		}

		if (!(o instanceof FlightSchedule)) {
			return false;
		}

		//EXCEPTION HANDLER
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
