package net.ipc.utils

import static org.junit.Assert.*

import grails.test.mixin.*
import grails.test.mixin.support.*
import org.junit.*
import java.text.SimpleDateFormat;

class DateUtilsTests {

	@Test
	public void successfullyNormalizeExpiryDate(){
		assertEquals("08/01/2014",DateUtils.normalizeExpiryDate("8/1/14"))
		assertEquals("08/01/2014",DateUtils.normalizeExpiryDate("8/01/14"))
		assertEquals("08/01/2014",DateUtils.normalizeExpiryDate("08/1/14"))
		assertEquals("08/20/2014",DateUtils.normalizeExpiryDate("8/20/14"))
		assertEquals("08/20/2014",DateUtils.normalizeExpiryDate("08/20/14"))
	}
    
	@Test
	public void successfullySkipValidExpiryDate(){
		assertEquals("08/20/2014",DateUtils.normalizeExpiryDate("08/20/2014"))
		assertEquals("8/20/2014",DateUtils.normalizeExpiryDate("8/20/2014"))		
		assertEquals("8/1/2014",DateUtils.normalizeExpiryDate("8/1/2014"))		
		assertEquals("8/01/2014",DateUtils.normalizeExpiryDate("8/01/2014"))		
		assertEquals("08/1/2014",DateUtils.normalizeExpiryDate("08/1/2014"))		
	}
}
