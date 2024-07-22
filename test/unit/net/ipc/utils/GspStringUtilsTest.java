package net.ipc.utils;

import static org.junit.Assert.*;

import java.math.BigDecimal;

import org.junit.Test;

import net.ipc.utils.GspStringUtils;

public class GspStringUtilsTest {

	@Test
	public void successfullyCallGetExistingBank() {
		assertEquals("UCPBPHMM", GspStringUtils.getExistingBank("UCPBPHMM", ""));
		assertEquals("UCPBPHMM", GspStringUtils.getExistingBank("", "UCPBPHMM"));		
		assertEquals("UCPBPHMM", GspStringUtils.getExistingBank("UCPBPHMM", null));		
		assertEquals("UCPBPHMM", GspStringUtils.getExistingBank(null, "UCPBPHMM"));		
	}
	
	@Test
	public void testIsNotEmpty(){
		assertEquals(true,GspStringUtils.isNotEmpty(null,""," ","test"));
		assertEquals(true,GspStringUtils.isNotEmpty(null,""," ",false));
		assertEquals(true,GspStringUtils.isNotEmpty(null,""," ",1234));
		assertEquals(true,GspStringUtils.isNotEmpty(null,""," ",new BigDecimal("10.00")));
		assertEquals(false,GspStringUtils.isNotEmpty(null,"","   "));
	}
	
	@Test
	public void testGetExistingValue(){
		assertEquals("TEST",GspStringUtils.getExistingValue(null,"TEST"));
		assertEquals("123",GspStringUtils.getExistingValue(null,123));
		assertEquals("123",GspStringUtils.getExistingValue(null,new BigDecimal("123")));
		
		assertEquals("TEST",GspStringUtils.getExistingValue("TEST",null));
		assertEquals("123",GspStringUtils.getExistingValue(123,null));
		assertEquals("123",GspStringUtils.getExistingValue(new BigDecimal("123"),null));
		
		assertEquals("TEST",GspStringUtils.getExistingValue("TEST",null,"TEST2"));
		
		assertEquals("",GspStringUtils.getExistingValue(" ",null,""));
		
	}
}
