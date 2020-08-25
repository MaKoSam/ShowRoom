//MARK: - Resources
package resources;

//MARK: - Lib's
import java.util.Objects;

public class Train implements Resource {

	//MARK: - Properties
	String number;
	String type;
	int seats;

	//MARK: - Init
	//MARK: - CASE HANDLING EXCEPTIONS
	public Train(String number, String type, int seats) {
		this.number = number.toLowerCase();
		this.type 	= type.toLowerCase();
		this.seats 	= seats.toLowerCase();
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

	//MARK: - Check Rep for correct work
	boolean checkRep() {
		return this instanceof Train ? true : false
	}

	@Override public boolean equals(Object o) {
		if (this == o) {
			return true;
		}

		if (!(o instanceof Train)) {
			return false;
		}

		Train tmp = (Train) o;
		return Objects.equals(tmp.number, number) && Objects.equals(tmp.type, type)
				&& tmp.seats == seats;
	}

	@Override public int hashCode() {
		return Objects.hashCode(number);
	}

	@Override public String toString() {
		return number + ": " + type + " > " + seats + "seats.";
	}
}
