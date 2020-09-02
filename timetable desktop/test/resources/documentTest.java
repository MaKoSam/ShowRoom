package resources;

import static org.junit.jupiter.api.Assertions.*;
import java.time.*;
import java.time.format.DateTimeFormatter;

import org.junit.jupiter.api.Test;

class documentTest {
	Document doc = new Document("123","321","2019-10-11");
	Document doc2 = doc;
	Document doc3 = new Document("123","321","2018-10-12");
	@Test
	void test() {
		assertEquals(doc.getDocName(),"123");
		LocalDate date = LocalDate.parse("2019-10-11",DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		assertEquals(doc.getPublishDate(),date);
		assertEquals(doc.getPublishDepartment(),"321");
		assertEquals(doc.equals(doc2),true);
		assertEquals(doc.equals(doc3),false);
		assertEquals(doc.hashCode(),doc2.hashCode());
	}
}
