//MARK: - Board child-class
package board;

//MARK: - Lib's
import java.util.*;
import java.time.*;
import java.time.format.DateTimeFormatter;

//MARK: - Packages
import collection.*;
import planningentry.*;
import resources.*;

public class StudyBoard extends Board {
	
	//MARK: - Init
	public StudyBoard(PlanningEntryCollection planningEntryCollection) {
		super(planningEntryCollection);
	}

	//MARK: - Visualisation
	@Override public void visualize(String currentTime, String locationName, int locationIndex) {
		Iterator <PlanningEntry <Resource>> iterator = super.iterator();
		Vector <Vector <?>> tableData 	= new Vector<>();
		Vector <String> tableNames 		= new Vector<>();
		String[] tableAttributes 		= new String[] { "Beginning Time",
														 "Ending Time",
														 "EntryNumber",
														 "Status" };
		for (String attribute: tableAttributes) {
			 tableNames.add(attribute);
		}

		while (iterator.hasNext()) {
			StudySchedule <Resource> planningEntry = (StudySchedule <Resource>) iterator.next();
			if (!locationName.isEmpty()) {
					if (!planningEntry.getStrLocation().toLowerCase().contentEquals(locationName.toLowerCase())) {
						continue;
					}
			}

			String scheduleBeginningTime = planningEntry.getBeginningTime().toString();
			String scheduleEndingTime = planningEntry.getEndingTime().toString();
			String planningEntryNumber = planningEntry.getPlanningEntryNumber();
			String status = planningEntry.getState().getStrState();

			Vector<String> tableRow = new Vector<>();
			tableRow.add(scheduleBeginningTime);
			tableRow.add(scheduleEndingTime);
			tableRow.add(planningEntryNumber);
			tableRow.add(status);
			
			tableData.add((Vector <?>)tableRow.clone());
		}
		makeTable(tableData, tableNames, currentTime + " " + locationName);
	}
}
