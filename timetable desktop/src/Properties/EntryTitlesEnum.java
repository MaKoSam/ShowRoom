//MARK: - Properties Package
package Properties;

import java.util.*;

public enum EntryTitlesEnum {
	PLANE,
	TRAIN,
	CLASS,
	UNKNOWN;

	//MARK: - Init
	public EntryTitlesEnum(String entry) {
		if (entry.toUpperCase() == "PLANE") return PLANE;
		if (entry.toUpperCase() == "TRAIN") return TRAIN;
		if (entry.toUpperCase() == "CLASS") return CLASS;

		//MARK: - EXCEPTION handling
		return UNKNOWN
	}
}