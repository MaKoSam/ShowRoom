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

public class TrainBoard extends Board {

	//MARK: - Properties
	private static final int hourRange 		=  1;
	public static final  int arrivalIndex 	=  1;
	public static final  int departureIndex = -1;
	
	//MARK: - Init
	public TrainBoard(PlanningEntryCollection planningEntryCollection) {
		super(planningEntryCollection);
	}

	//MARK: - Visualisation
	@Override public void visualize(String currentTime, String locationName, int locationIndex) {
		Iterator <PlanningEntry <Resource>> iterator = super.iterator();
		Vector <Vector <?>> tableData 	= new Vector<>();
		Vector <String> tableNames 		= new Vector<>();
		String[] tableAttributes 		= new String[] { "Time",
														 "EntryNumber",
														 "Departure",
														 "Arrival",
														 "Status" };
		for (String attribute: tableAttributes){
			 tableNames.add(attribute);
		}

		while (iterator.hasNext()) {
			TrainSchedule <Resource> planningEntry = (TrainSchedule <Resource>) iterator.next();
			for (int i = 0; i < planningEntry.LENGTH; i++) {
				if (planningEntry.getLocationOfIndex(i).contentEquals(locationName)) {

					LocalDateTime currentTimeFormatted 	= LocalDateTime.parse(currentTime,DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
					LocalDateTime scheduleTimeFormatted = locationIndex == FlightBoard.arrivalIndex ? planningEntry.getTimeArrival() : planningEntry.getTimeLeaving();

					if (scheduleTimeFormatted.isBefore(currentTimeFormatted.plusHours(hourRange)) && 
							scheduleTimeFormatted.isAfter(currentTimeFormatted.minusHours(hourRange)) ) {

						String scheduleTableTime 	= scheduleTimeFormatted.toString().substring(11);
						String planningEntryNumber 	= planningEntry.getPlanningEntryNumber();
						String locationOrigin 		= planningEntry.getLocationOfIndex(planningEntry.arrivalIndex);
						String locationTerminal 	= planningEntry.getLocationOfIndex(planningEntry.departureIndex);
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
			}
		}
		makeTable(tableData, tableNames, locationIndex == arrivalIndex ? "Arrivals" : "Departures");
	}
}
