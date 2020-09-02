//MARK: - Collection Superclass
package collection;

//MARK: - Lib's
import java.util.*;

//MARK: - Packages
import resources.*;
import planningentry.*;

public abstract class PlanningEntryCollection {

	//MARK: - Properties Protected
	//MARK: - Protected properties ensure safety & correctness & robustness
	//MARK: - Protected properies ensure that data is storet privately
	// 		  and that there are no data wastes.
	protected Set<String> collectionLocation;
	protected Set<Resource> collectionResource;
	protected List<PlanningEntry<Resource>> planningEntries = new ArrayList<>();
	
	//MARK: - Abstract Functions are part af ADT and futher easy maintenanse and debugging
	abstract PlanningEntry<Resource> addPlanningEntry(String stringinfo);
	abstract Resource allocatePlanningEntry(String planningEntryNumber, String stringinfo);
	
	//MARK: - Init
	public PlanningEntryCollection() {
		this.collectionLocation = new HashSet<>();
		this.collectionResource = new HashSet<>();
		this.planningEntries 	= new ArrayList<>();
	}

	public PlanningEntry<Resource> getPlanningEntryByStrNumber(String planningEntryNumber) {
		for (PlanningEntry<Resource> entry: planningEntries) {
			if (entry.getPlanningEntryNumber().equals(planningEntryNumber))
				return entry;
		}
		return null;
	}

	public Boolean startPlanningEntry(String planningEntryNumber) {
		PlanningEntry<Resource> planningEntry = this.getPlanningEntryByStrNumber(planningEntryNumber);
		return planningEntry == null ? false : planningEntry.start();
	}
	
	public Boolean blockPlanningEntry(String planningEntryNumber) {
		PlanningEntry<Resource> planningEntry = this.getPlanningEntryByStrNumber(planningEntryNumber);
		return planningEntry == null ? false : planningEntry.block();
	}
	
	public Boolean cancelPlanningEntry(String planningEntryNumber) {
		PlanningEntry<Resource> planningEntry = this.getPlanningEntryByStrNumber(planningEntryNumber);
		return planningEntry == null ? false : planningEntry.cancel();
	}
	
	public Boolean endPlanningEntry(String planningEntryNumber) {
		PlanningEntry<Resource> planningEntry = this.getPlanningEntryByStrNumber(planningEntryNumber);
		return planningEntry == null ? false : planningEntry.end();
	}
	
	public Set<String> getAllLocation() {
		return this.collectionLocation;
	}
	
	public Set<Resource> getAllResource() {
		return this.collectionResource;
	}
	
	public List<PlanningEntry<Resource>> getAllPlanningEntries() {
		return this.planningEntries;
	}
	
	public boolean deleteLocation(String location) {
		for (String superLocation: collectionLocation)
			if (superLocation == location) {
				collectionLocation.remove(superLocation);
				return true;
			}
		return false;
	}
	
	public boolean deleteResource(Resource resource) {
		for (Resource superResource: collectionResource)
			if (superResource.equals(resource)) {
				collectionResource.remove(superResource);
				return true;
			}
		return false;
	}
}
