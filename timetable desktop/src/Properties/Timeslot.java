//MARK: - Properties Package
package Properties;

//MARK: - AF:
//arrivalTime shows the arrival time to arrival location
//departureTime shows the departure time from departure location
 
//MARK: - Flight Schedule:
//Two Objects
//Arrival Time & Departure Time at index 0
//Arrival Time & Departure Time at index 1

//MARK: - Train Schedule:
//Two Objects
//Arrival Time & Departure Time at index 0
//Arrival Time & Departure Time at index 1

//MARK: - Activity Schedule:
//One object
//Start Time & End Time at index 0

//MARK: - RI:
//the length of arrival and departure should be equal
//departureTime[index] should be later than arrivalTime[index]
//when i < length arrivalTime[index] and departureTime[index] should be non-null

//MARK: - Safety: immutable variables

//MARK: - Additional Lib's
import java.util.*;
import java.time.*;
import java.time.format.DateTimeFormatter;

public class TimeSlot {

	//MARK: - Properties
	private final List<LocalDateTime> arrivalTime 	= new ArrayList<>();
	private final List<LocalDateTime> departureTime = new ArrayList<>();

	//MARK: - Safe timePattern for EXCEPTION handling
	private String timeFormatPattern = "yyyy-MM-dd HH:mm";
	
	//MARK: - Init
	public TimeSlot(List<String> arrive, List<String> departure) {
		for (String time: arrive) {

			//MARK: - EXCEPTION handling
			LocalDateTime timeFormatted = LocalDateTime.parse(time, DateTimeFormatter.ofPattern(timeFormatPattern));
			this.arrivalTime.add(timeFormatted);
		}
		for (String time: departure) {

			//MARK: - EXCEPTION handling
			LocalDateTime timeFormatted = LocalDateTime.parse(time, DateTimeFormatter.ofPattern(timeFormatPattern));
			this.departureTime.add(timeFormatted);
		}
	}

	//MARK: - Safe return of arrival times
	public List<LocalDateTime> getArrivalTime() {
		return this.arrivalTime;
	}

	//MARK: - Safe return of departure times
	public List<LocalDateTime> getDepartureTime() {
		return this.departureTime;
	}

	private void checkRep() {
    	assert (arrivalTime.size() == departureTime.size());
    	for (int i = 0; i < arrivalTime.size(); i++) {
        	assert (arrivalTime.get(i) != null);
        	assert (departureTime.get(i) != null);
    	}
	}

	//MARK: - Equality
	@Override public boolean equals(Object o) {
		if (o == this) {
			 return true;
		}

		if (!(o instanceof TimeSlot)) {
			 return false;
		}

		TimeSlot tmp = (TimeSlot) o;
		return Objects.deepEquals(arrivalTime, tmp.getArrivalTime()) &&
			   Objects.deepEquals(departureTime, tmp.getDepartureTime());
	}

	//MARK: - Hash value
	@Override public int hashCode() {
		return Objects.hashCode(arrivalTime) + Objects.hashCode(departureTime);
	}
}
