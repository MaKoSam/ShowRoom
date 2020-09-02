//MARK: - Resources Super class
package resources;

public interface Resource {
	
	//MARK: - Doc Init
	public static Document newResourceOfDoc(String docName,
											String publishDepartment, 
											String publishDate) {
		return new Document(docName, publishDepartment, publishDate);
	}

	//MARK: - Plane Init
	public static Plane newResourceOfPlane(String number, String type, int seats, double age) {
		return new Plane(number, type, seats, age);
	}

	//MARK: - Train Init
	public static Train newResourceOfTrain(String number, String type, int seats) {
		return new Train(number, type, seats);
	}
}