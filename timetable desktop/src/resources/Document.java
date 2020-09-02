//MARK: - Resources
package resources;

//MARK: - Lib's
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

public class Document implements Resource {

	//MARK: - Properties
	String documentName;
	String publishDepartment;
	LocalDate publishDate;

	//MARK: - EXCEPTION handling
	private String timePattern = "yyyy-MM-dd";
	
	//MARK: - Init
	public Document(String docName, 
					String strPublishDepartment, 
					String strPublishDate) {
		this.documentName 		= docName;
		this.publishDepartment 	= strPublishDepartment;
		this.publishDate		= LocalDate.parse(strPublishDate, DateTimeFormatter.ofPattern(timePattern));
	}
	
	public String getDocumentName() {
		return this.documentName;
	}
	
	public String getPublishDepartment() {
		return this.publishDepartment;
	}
	
	public LocalDate getPublishDate() {
		return this.publishDate;
	}

	boolean checkRep() {
		return this instanceof Document ? true : false
	}

	@Override public boolean equals(Object o) {
		if (o == this){
			return true;
		}

		if (!(o instanceof Document)) {
			return false;
		}

		Document tmp = (Document) o;
		return Objects.equals(tmp.documentName, documentName) && 
			   Objects.equals(tmp.publishDepartment, publishDepartment) && 
			   Objects.deepEquals(tmp.publishDate, publishDate);
	}

	@Override public int hashCode() {
		return Objects.hashCode(documentName);
	}

	@Override public String toString() {
		return documentName + ": " + publishDepartment + " > " + publishDate.toString();
	}
}
