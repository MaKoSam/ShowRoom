//MARK: - Collection Subclass
package collection;

//MARK: - Lib's
import java.util.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.Logging;

//MARK: - Packages
import planningentry.*;
import Properties.*;
import resources.*;

public class FlightScheduleCollection extends PlanningEntryCollection {

	//MARK: - Logging
	private final static Logger logger = Logger.getLogger("Flight_Log");

	//MARK: - Properties
	private String compilePatternFlight = "Flight:(.*?),(.*?)\n\\{\nDepartureAirport:(.*?)\nArrivalAirport:(.*?)\nDepatureTime:(.*?)\nArrivalTime:(.*?)\nPlane:(.*?)\n\\{\nType:(.*?)\nSeats:(.*?)\nAge:(.*?)\n\\}\n\\}\n";
	private String compilePatternPlane = "Plane:(.*?)\n\\{\nType:(.*?)\nSeats:(.*?)\nAge:(.*?)\n\\}\n";	

	//MARK: - Init
	public FlightScheduleCollection(){
		this.collectionLocation = new HashSet<>();
		this.collectionResource = new HashSet<>();
		this.planningEntries 	= new ArrayList<>();
	}
	
	public FlightSchedule<Resource> addPlanningEntry(String planningEntryNumber, 
													 String departureAirport,
													 String arrivalAirport,
													 String departureTime, 
													 String arrivalTime) {
		Location location = new Location(departureAirport, arrivalAirport);
		TimeSlot timeslot = new TimeSlot(Arrays.asList(departureTime, arrivalTime), 
										 Arrays.asList(departureTime, arrivalTime));

		this.collectionLocation.addAll(location.getLocations());
		PlanningEntry<Resource> flightSchedule = PlanningEntry.newFlightSchedule(location, 
																				 timeslot,
																				 planningEntryNumber);
		this.planningEntries.add(flightSchedule);
		return (FlightSchedule<Resource>) flightSchedule;
	}

	@Override public FlightSchedule<Resource> addPlanningEntry(String stringinfo) throws DataPatternException {
		//MARK: - Pattern types are stored as private properties and are not mutable
		Pattern patternFlight = Pattern.compile(compilePatternFlight);
		Matcher matcher = patternFlight.matcher(stringinfo);

		//MARK: - If input is incorrect => Program won't execute input data and skip
		//MARK: - No Exception occur 
		if (!matcher.find()) {
			throw new DataPatternException("Data Parse Error: " + stringinfo);
			//MARK: - Error Loggin
			logger.log(Level.Error, "Data Parse error" + stringinfo);
		}

		//MARK: - If any of input files have wrong Casing -> All will fix with lower Case;
		String planningEntryNumber 	= matcher.group(2).toLowerCase();
		String departureAirport 	= matcher.group(3).toLowerCase();
		String arrivalAirport 		= matcher.group(4).toLowerCase();
		String departureTime 		= matcher.group(5).toLowerCase();
		String arrivalTime 			= matcher.group(6).toLowerCase();

		//MARK: - Loggin
		logger.log(Level.Info, "New entry added");
		return this.addPlanningEntry(planningEntryNumber, 
									 departureAirport, 
									 arrivalAirport,
									 departureTime,
									 arrivalTime);
	}
	
	//MARK: - Allocate Resource proccess is stepping as checkRep
	//MARK: - While allocation, programm insures that resource has data of coorect type
	public Resource allocateResource(String planningEntryNumber, 
									 String number, 
									 String type, 
									 int seats, 
									 double age) {
		Plane plane = Resource.newResourceOfPlane(number, type, seats, age);
		FlightSchedule<Resource> tmp = (FlightSchedule<Resource>) this.getPlanningEntryByStrNumber(planningEntryNumber);
		tmp.allocateResource(plane);
		this.collectionResource.add(plane);

		logger.log(Level.Info, "Resources allocated");
		return plane;
	}

	//MARK: - Incorrect Plane Format
	public static void checkEntryNumber(String planningEntryNumber) throws EntryNumberFormatException {
    	if (Character.isUpperCase(planningEntryNumber.charAt(0)) &&
    	    Character.isUpperCase(planningEntryNumber.charAt(1))) {
        	for (int i = 2; i < planningEntryNumber.length(); i++) {
            	if (!Character.isDigit(planningEntryNumber.charAt(i)))
                	throw new EntryNumberFormatException(planningEntryNumber);
                	//MARK: - Error Loggin
                	logger.log(Level.Error, "Plane data inaccurate");
        	}
    	} else {
        	throw new EntryNumberFormatException(planningEntryNumber);
    	}
	}

	@Override public Resource allocatePlanningEntry(String planningEntryNumber, String stringinfo) {
		if (this.getPlanningEntryByStrNumber(planningEntryNumber) == null){
			return null;
		}

		//MARK: - Pattern types are stored as private properties and are not mutable
		Pattern patternFlight = Pattern.compile(compilePatternFlight);
		Pattern patternPlane = Pattern.compile(compilePatternPlane);
		Matcher matcher = pattern1.matcher(stringinfo);

		//MARK: - If input is incorrect => Program won't execute input data and skip
		//MARK: - No Exception occur
		if (!matcher.find()) {
			matcher = patternPlane.matcher(stringinfo);
			if (!matcher.find()) return null;
		}

		//MARK: - If any of input files have wrong Casing -> All will fix with lower Case;
		String number 	= matcher.group(7).toLowerCase();
		String type 	= matcher.group(8).toLowerCase();
		int seats 		= Integer.valueOf(matcher.group(9));
		double age 		= Double.valueOf(matcher.group(10));

		//MARK: - Programm Info Loggin
		logger.log(Level.Info, "New plane allocated: " + number);
		return this.allocateResource(planningEntryNumber, 
									 number, 
									 type, 
									 seats, 
									 age);
	}
}
