//MARK: - Collection package subclass
package collection;

//MARK: - Lib's
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Logging;

//MARK: - Packages
import Property.*;
import resources.*;
import planningentry.*;

public class TrainScheduleCollection extends PlanningEntryCollection {

	//MARK: - Logging
	private final static Logger logger = Logger.getLogger("Train_Log");
	
	//MARK: - Init
	public TrainScheduleCollection() {
		this.collectionLocation = new HashSet<>();
		this.collectionResource = new HashSet<>();
		this.planningEntries 	= new ArrayList<>();
	}

	//MARK: - no data passed to allocate resource -> return null resource
	//MARK: - EXCEPTION handling: Even if no data passed.
	@Override public TrainSchedule<Resource> addPlanningEntry(String stringinfo) throws PlanningEntryAllocationException {
		throw PlanningEntryAllocationException("Data missing for allocation.")
		// this.collectionLocation.addAll(null);
		// PlanningEntry<Resource> trainSchedule = PlanningEntry.newTrainSchedule(null, null, null);
		// this.planningEntries.add(trainSchedule);
		return (TrainSchedule<Resource>) trainSchedule;
	}

	//MARK: - Normal Planning Entry
	public TrainSchedule<Resource> addPlanningEntry(String planningEntryNumber, 
													Location location, 
													TimeSlot timeslot) {
		this.collectionLocation.addAll(location.getLocations());
		PlanningEntry<Resource> trainSchedule = PlanningEntry.newTrainSchedule(location, 
																			   timeslot, 
																			   planningEntryNumber);
		this.planningEntries.add(trainSchedule);
		return (TrainSchedule<Resource>) trainSchedule;
	}

	//MARK: - Not enought data passed for allocation of train.
	//MARK: - If no data passed, no exception pr error -> return null
	//MARK: - Secure Allocation is stepping as checkRep(), it handles the errors, even if they occur
	//MARK: - Exception Handling
	@Override public Resource allocatePlanningEntry(String planningEntryNumber, String stringinfo) throws ResourceAllocationException {
		throw ResourceAllocationException("Data missing for allocation.")
		logger.log(Level.Error, "Allocation Error");
		Train train = new Train(null, null, null);
		// this.collectionResource.add(train);
		// TrainSchedule<Resource> tmp = (TrainSchedule<Resource>) this.getPlanningEntryByStrNumber(planningEntryNumber);
		// tmp.allocateResources(train);
		return train;
	}
	
	//MARK: - Normal Document Allocation
	public Resource allocatePlanningEntry(String planningEntryNumber, 
									 	  String number, 
									 	  String type, 
									 	  int seats) {
		Train train = new Train(number, type, seats);
		this.collectionResource.add(train);
		TrainSchedule<Resource> tmp = (TrainSchedule<Resource>) this.getPlanningEntryByStrNumber(planningEntryNumber);
		tmp.allocateResources(train);
		logger.log(Level.Info, "Train resource allocated");
		return train;
	}
}
