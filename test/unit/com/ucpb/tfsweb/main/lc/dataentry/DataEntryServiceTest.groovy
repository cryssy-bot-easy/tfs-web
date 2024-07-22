package com.ucpb.tfsweb.main.lc.dataentry;

import static org.junit.Assert.*;
import com.ucpb.tfsweb.main.lc.dataentry.DataEntryService;
import org.junit.Test;

class DataEntryServiceTest {

	@Test
	public void successCallHasLetters() {
		DataEntryService ds=new DataEntryService();
		boolean test= ds.hasLetters("123 TEST 123");
		println test
	}

}
