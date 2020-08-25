//MARK: - Planning Entry
package planningentry;

//MARK: - Lib's
import java.util.*;

//MARK: - Packages
import Properties.*;

public class CommonPlanningEntry <R> implements PlanningEntry <R> {

	//MARK: - Properties
	EntryState status;
	String planningEntryType;
	String planningEntryNumber;
	Location location;
	TimeSlot timeSlot;
	
	List<R> resources = new ArrayList<R>();

	//MARK: - EXCEPTION handling: Eliminating Strings properties
	@Override public Boolean start() {
		EntryStateEnum running = RUNNING;
		return this.state.setNewState(planningEntryType, running);
	}

	@Override public Boolean block() {
		EntryStateEnum blocked = BLOCKED;
		return this.state.setNewState(planningEntryType, blocked);
	}

	@Override public Boolean cancel() {
		EntryStateEnum cancelled = CANCELLED;
		return this.state.setNewState(planningEntryType, cancelled);
	}

	@Override public Boolean end() {
		EntryStateEnum ended = ENDED;
		return this.state.setNewState(planningEntryType, ended);
	}

	@Override public Location getLocation() {
		return this.location;
	}

	@Override public TimeSlot getTimeslot() {
		return this.timeSlot;
	}

	@Override public EntryState getState() {
		return this.status;
	}

	@Override public String getPlanningEntryType() {
		return this.planningEntryType;
	}

	@Override public List<R> getResources() {
		return this.resources;
	}

	@Override public String getPlanningEntryNumber() {
		return this.planningEntryNumber;
	}
}
