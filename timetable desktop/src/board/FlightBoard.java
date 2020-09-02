/* MARK:
 * - Board child-class
 */
package board;

/* MARK:
 * - Lib's
 */
import java.util.*;
import java.time.*;
import java.time.format.DateTimeFormatter;

/* MARK:
 * - Packages
 */
import collection.*;
import planningentry.*;
import resources.*;

public class FlightBoard extends Board {
	
	/* MARK:
	 * - Properties
	 */
	private static final int hourRange 		=  1;
	public static final  int arrivalIndex 	=  1;
	public static final  int departureIndex = -1;
	
	/* MARK:
	 * - Init
	 */
	public FlightBoard(PlanningEntryCollection planningEntryCollection) {
		super(planningEntryCollection);
	}

	/* MARK:
	 * - Visualisation
	 */
	@Override public void visualize(String currentTime, String locationName, int locationIndex) {
		Iterator <PlanningEntry <Resource>> iterator = super.iterator();
		Vector <Vector <?>> tableData 	= new Vector<>();
		Vector <String> tableNames 		= new Vector<>();
		String[] tableAttributes 		= new String[] { "Time",
														 "EntryNumber",
														 "Departure",
														 "Arrival",
														 "Status" };
		for (String attribute: tableAttributes) {
			tableNames.add(attribute);
		}

		while (iterator.hasNext()) {
			FlightSchedule<Resource> planningEntry = (FlightSchedule <Resource>) iterator.next();
			if (!locationName.isEmpty()) {
				if (locationIndex == FlightBoard.arrivalIndex) {
					if (!planningEntry.getArrivalLocation().toLowerCase().contentEquals(locationName.toLowerCase())) {
						continue;
					}
				} else
				if (!planningEntry.getDepartureLocation().toLowerCase().contentEquals(locationName.toLowerCase())) {
						continue;
				}
			}

			LocalDateTime currentTimeFormatted 	= LocalDateTime.parse(currentTime,DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
			LocalDateTime scheduleTimeFormatted = locationIndex == FlightBoard.arrivalIndex ? planningEntry.getArrvalTime() : planningEntry.getDeoartureTime();

			if (scheduleTime.isBefore(currentTimeFormatted.plusHours(hourRange)) && 
					scheduleTime.isAfter(currentTime.minusHours(hourRange))) {

				String scheduleTableTime 	= scheduleTimeFormatted.toString().substring(11);
				String planningEntryNumber 	= planningEntry.getPlanningEntryNumber();
				String locationDeparture	= planningEntry.getDepartureLocation();
				String locationArrival  	= planningEntry.getArrivalLocation();
				String status 				= planningEntry.getState().getStrState();

				Vector<String> tableRow 	= new Vector<>();
				tableRow.add(scheduleTableTime);
				tableRow.add(planningEntryNumber);
				tableRow.add(locationDeparture);
				tableRow.add(locationArrival);
				tableRow.add(state);

				tableData.add((Vector <?>) tableRow.clone());
			}
		}

		makeTable(tableData, tableNames, locationIndex == arrivalIndex ? "Arrivals" : "Departures");
	}
}
