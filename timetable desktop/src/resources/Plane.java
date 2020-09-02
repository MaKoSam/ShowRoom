//MARK: - Resources
package resources;

//MARK: - Lib's
import java.util.Objects;

public class Plane implements Resource {

	//MARK: - Properties
	String number;
	String type;
	int seats;
	double age;
	
	//MARK: - Init
	//MARK: - CASE HANDLING EXCEPTIONS
	public Plane(String number, String type, int seats, double age) {
		this.number = number.toLowerCase();
		this.type 	= type.toLowerCase();
		this.seats  = intseats;
		this.age    = age;
	}
	

	public String getNumber() {
		return this.number;
	}

	public String getType() {
		return this.type;
	}

	public int getSeats() {
		return this.seats;
	}

	public double age() {
		return this.age;
	}

	//MARK: - CheckRep for correct work
	boolean checkRep() {
		return this instanceof Plane ? true : false
	}

	//MARK: - Time Exceptions
	public static void checkTime(String departureTime, String arrivalTime) throws TimeOrderException, DateTimeParseException {
    	LocalDateTime dt = null, at = null;
    	try {
        	dt = LocalDateTime.parse(departureTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
        	at = LocalDateTime.parse(arrivalTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    	} catch (Exception e) {
        	throw new DateTimeParseException("Time data missmatch");
    	} finally {
        	if (dt != null && at != null) {
            	if (!dt.isBefore(at))
                	throw new TimeOrderException("Incorrect Times");
        }
    }
	}

	@Override public boolean equals(Object o) {
		if (o == this) {
			return true;
		}

		if (!(o instanceof Plane)) {
			return false;
		}

		Plane tmp = (Plane) o;
		return Objects.equals(tmp.number, number) && 
			   Objects.equals(tmp.type, type) && 
			   tmp.seats == seats && 
			   tmp.age == age;
	}

	@Override public int hashCode() {
		return Objects.hashCode(number);
	}

	@Override public String toString() {
		return number + ": " + type + " > " + seats + "seats > " + age + "yr.";
	}
}
