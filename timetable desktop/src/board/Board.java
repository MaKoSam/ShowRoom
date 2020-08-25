/* MARK:
 * - Board super-class
 */

package board;

/* MARK:
 * - Lib's
 */

import javax.swing.*;
import java.util.*;

/* MARK:
 * - Packages
 */
import collection.*;
import planningentry.*;
import resources.*;


public abstract class Board {

	/* MARK:
	 * - Properties
	 */
	protected JFrame frame;
	protected PlanningEntryCollection planningEntryCollection;
	
	/* MARK:
	 * - Init
	 */
	Board(PlanningEntryCollection planningEntryCollection) {
		this.planningEntryCollection = planningEntryCollection;
	}

	
	Iterator <PlanningEntry<Resource>> iterator() {
		return planningEntryCollection.getAllPlanningEntries().iterator();
	}

	/* MARK: 
	 * - Visualization	
	 */ 
	protected void makeTable(Vector<Vector<?>> tableData, Vector<String> tableNames, String title) {
		JTable table = new JTable(tableData, tableNames);

		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setViewportView(table);

		frame = new JFrame();
		frame.setVisible(true);
		frame.setTitle(title);
		frame.setBounds(0, 0, 1280, 720);
		frame.add(scrollPane);
	}


	abstract void visualize(String strCurrentTime, String strLocation, int intType);
}
