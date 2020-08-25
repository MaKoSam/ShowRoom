package Properties;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class entryStateTest {
	EntryState state = new EntryState("Waiting");
	EntryState state2 = new EntryState("Waiting");
	EntryState state3 = new EntryState("Running");
	@Test
	void test() {
		assertEquals(state.equals(state2),true);
		assertEquals(state.equals(state3),false);
		assertEquals(state.hashCode(),state2.hashCode());
		assertEquals(state.getStrState(),"WAITING");
		assertEquals(state.setNewState("Train", "Allocated"),true);
		assertEquals(state.getStrState(),"ALLOCATED");
		assertEquals(state.setNewState("Plane", "Running"),true);
		assertEquals(state.setNewState("Plane", "Blocked"),false);
		assertEquals(state3.setNewState("Train", "Blocked"),true);
	}

}
