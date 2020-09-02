//MARK: - Collection package sub-class
package collection;

//MARK: - Lib's
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Logging;

//MARK: - Packages
import Properties.*;
import resources.*;
import planningentry.*;

public class StudyScheduleCollection extends PlanningEntryCollection {

	//MARK: - Logging
	private final static Logger logger = Logger.getLogger("Study_Log");

	//MARK: - Init
	public StudyScheduleCollection() {
		this.collectionLocation = new HashSet<>();
		this.collectionResource = new HashSet<>();
		this.planningEntries 	= new ArrayList<>();
	}

	//MARK: - no data passed to allocate resource -> return null resource
	//MARK: - Secure Allocation is stepping as checkRep(), it handles the errors, even if they occur
	//MARK: - EXCEPTION handling: Even if no data passed.
	@Override public StudySchedule<Resource> addPlanningEntry(String stringinfo) throws PlanningEntryAllocationException {
		throw PlanningEntryAllocationException("Not enough data for allocation");
		
		// Location location = new Location(null);
		// TimeSlot timeslot = new TimeSlot(Arrays.asList(null),Arrays.asList(null));

		// this.collectionLocation.addAll(null)
		// PlanningEntry<Resource> studySchedule = PlanningEntry.newStudySchedule(location, 
		// 																	   timeslot, 
		// 																	   planningEntryNumber);
		// this.planningEntries.add(studySchedule);
		return (StudySchedule<Resource>) studySchedule;
	}

	//MARK: - Normal Planning Entry
	public StudySchedule<Resource> addPlanningEntry(String planningEntryNumber, 
													String strLocation,
													String startTime, 
													String endTime) {
		Location location = new Location(strLocation);
		TimeSlot timeslot = new TimeSlot(Arrays.asList(startTime),Arrays.asList(endTime));

		this.collectionLocation.addAll(location.getLocations());
		PlanningEntry<Resource> studySchedule = PlanningEntry.newStudySchedule(location, 
																			   timeslot, 
																			   planningEntryNumber);
		this.planningEntries.add(studySchedule);
		return (StudySchedule<Resource>) studySchedule;
	}

	//MARK: - If no data passed, no exception pr error -> return null
	//MARK: - Secure Allocation is stepping as checkRep(), it handles the errors, even if they occur
	//MARK: - Exception Handling
	@Override public Resource allocatePlanningEntry(String planningEntryNumber, String stringinfo) throws ResourceAllocationException {
		throw ResourceAllocationException("Not enough data for allocation");
		logger.log(Level.Error, "Allocation error");
		Document document = null;
		this.collectionResource.add(document);
		StudySchedule<Resource> tmp = (StudySchedule<Resource>) this.getPlanningEntryByStrNumber(planningEntryNumber);
		tmp.allocateResources(document);
	}

	//MARK: - Normal Document Allocation
	public Resource allocatePlanningEntry(String planningEntryNumber, 
										  String docName,
										  String publishmentDepartment, 
										  String strPublishDate) {
		Document document = new Document(docName, publishmentDepartment, strPublishDate);
		this.collectionResource.add(document);
		StudySchedule<Resource> tmp = (StudySchedule<Resource>) this.getPlanningEntryByStrNumber(planningEntryNumber);
		tmp.allocateResources(document);
		return document;
	}
}
