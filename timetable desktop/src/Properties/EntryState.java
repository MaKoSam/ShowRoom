//MARK: - Properties Package
package Properties;

import java.util.*;

public class EntryState  {

	//MARK: - Properties
	private EntryStateEnum state;
	private EntryTitleEnum entryTitle;
	
	public static final List<String> keyWords = new ArrayList<String>() {
		private static final long serialVersionUID = 1L; {
			add("plane"); //OR Plane, Class, Task
			entryTitle = EntryTitleEnum("plane")
		}
	};


	@Override public boolean equals(Object o) {
		if (o == this)
			return true;
		if (!(o instanceof EntryState)) 
			return false;

		EntryState tmp = (EntryState) o;
		return this.getStrState() == tmp.getStrState();
	}

	@Override public int hashCode() {
		return Objects.hashCode(this.getState());
	}

	//MARK: - Init
	public EntryState(String state) {
		//MARK: - EXCEPTION handling
		//Upper Case Statement catches problems 
		this.state = EntryStateEnum(state.toUpperCase());
	}

	
	public EntryStateEnum getState() {
		return this.state;
	}

	
	public String getStrState() {
		return this.getState().toString();
	}

	private Boolean setAvailability(String planningEntryType, String newState) {
		List<EntryStateEnum> availableStatesList = new ArrayList<EntryStateEnum>
			(Arrays.asList(this.getState().newStateAchievable(planningEntryType)));
		//MARK: EXCEPTION HANDLING: Upper Case
		return availableStatesList.contains(EntryStateEnum.valueOf(newState.toUpperCase()));
	}

	//MARK: - Updater With Exception Handling
	//MUTATOR Allocation
	public Boolean setNewState(String planningEntryType, EntryStateEnum newState) {
		if (this.setAvailability(planningEntryType, newState.toString())) {
			this.state = EntryStateEnum.valueOf(newState.toString());
			return true;
		} else{
		 	return false;
		}
	}

	//MARK: - Error Checking
	private Boolean checkRep() {
		assert(planningEntryType.toLowerCase().contains("plane")) ||
				!this.getStrState().toLowerCase().contentEquals("blocked");
		return entryTitle == PLANE ? true : false; 
	}
}
