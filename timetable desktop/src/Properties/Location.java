//MARK: - Properties Package
package Properties;
//MARK: - AF:
//locations represent the locations in the plan
//MARK: - RI:
//locations should be as long as arrival and departure in class TimeSlot
//MARK: - Safety: immutable variables


import java.util.*;

public class Location {

	//MARK: - Properties
	private final List<String> locations = new ArrayList<String>();
	
	private void checkRep() {
    	for (String departureLocation: locations) {
        	assert (departureLocation.length() > 0);
        	for (String arrivalLocation: locations) {
            	if (departureLocation != arrivalLocation)
            		
                	assert (!departureLocation.equals(arrivalLocation));
        	}
    	}
	}


	//MARK: - Init
	public Location(String...locationsList) {
		for (String place: locationsList) {
			this.locations.add(place);
		}
	}

	//MARK: - Safe return of value
	public List<String> getLocations() {
		return this.locations;
	}

	@Override public boolean equals(Object o) {
		if (o == this){
		 	return true;
		}

		if (!(o instanceof Location)){
			 return false;
		}

		Location tmp = (Location) o;
		return tmp.getLocations().equals(this.getLocations());
	}

	//MARK: - Hash value
	@Override public int hashCode() {
		return Objects.hashCode(locations);
	}
}