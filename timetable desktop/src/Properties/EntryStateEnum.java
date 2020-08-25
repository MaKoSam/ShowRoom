//MARK: - Properties Package
package Properties;

//MARK: - AF: the state enum's name represents the state 
//MARK: - RI: state must be in enums
//MARK: - Safety: no direct mutations, only mutating with plan & check

import java.util.*;

public enum EntryStateEnum  {
	WAITING,
	ALLOCATED,
	BLOCKED,
	RUNNING,
	ENDED,
	CANCELLED;

	//MARK: - Next Possible States of specific states
	public static final Map<EntryStateEnum, EntryStateEnum[]> newStateAchievableBlockedAble = new HashMap<EntryStateEnum, EntryStateEnum[]>() {
		private static final long serialVersionUID = 1L; {
			 put(WAITING, 	new EntryStateEnum[] {ALLOCATED, CANCELLED});
		     put(ALLOCATED, new EntryStateEnum[] {RUNNING, CANCELLED});
		     put(RUNNING, 	new EntryStateEnum[] {BLOCKED, ENDED});
		     put(BLOCKED, 	new EntryStateEnum[] {RUNNING, CANCELLED});
		     put(CANCELLED, new EntryStateEnum[] {});
		     put(ENDED, 	new EntryStateEnum[] {});
		}
	};


	public static final Map<EntryStateEnum, EntryStateEnum[]> newStateAchievableBlockedDisable = new HashMap<EntryStateEnum, EntryStateEnum[]>() {
		private static final long serialVersionUID = 1L; {
			put(WAITING, 	new EntryStateEnum[] {ALLOCATED, CANCELLED});
			put(ALLOCATED, 	new EntryStateEnum[] {RUNNING, CANCELLED});
			put(RUNNING, 	new EntryStateEnum[] {ENDED});
			put(CANCELLED, 	new EntryStateEnum[] {});
			put(ENDED, 		new EntryStateEnum[] {});
		}
	};

	public EntryStateEnum[] newStateAchievable(String planningEntryType) {
		for (String str: keyWords){
			if (planningEntryType.contains(str))
				return EntryStateEnum.newStateAchievableBlockedAble.get(this);
		} 
		return EntryStateEnum.newStateAchievableBlockedDisable.get(this);
	}

	public EntryStateEnum(String state) {
		if (state.toUpperCase() == "ALLOCATED") return ALLOCATED
		if (state.toUpperCase() == "WAITING") return WAITING
		if (state.toUpperCase() == "BLOCKED") return BLOCKED
		if (state.toUpperCase() == "RUNNING") return RUNNING
		if (state.toUpperCase() == "ENDED") return ENDED
		if (state.toUpperCase() == "CANCELLED") return CANCELLED

		//MARK: - Safety EXCEPRION if unknown state passed
		return BLOCKED
	}
}