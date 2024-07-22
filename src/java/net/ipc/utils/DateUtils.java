package net.ipc.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.StringUtils;


/**
 * PROLOGUE
 * SCR/ER Description: Add new format for date time
 *	[Revised by:] Jesse James Joson
 *	Program [Revision] Details: Add new function to change the system date in the needed format.
 *	Date deployment: 6/16/2016 
 *	Member Type: Java
 *	Project: Web
 *	Project Name: DateUtils.java 
*/

public class DateUtils {

	private static final SimpleDateFormat SIMPLE_DATE_FORMAT = new SimpleDateFormat();
	
	// formats
	private static final String SHORT_DATE_FORMAT = "MM/dd/yyyy";
    private static final String DATE_TIME_FORMAT = "MM/dd/yyyy hh:mm a";
    private static final String DATE_TIME = "MM/dd/yyyy hh:mm:ss a";
    private static final String FULL_DATE_FORMAT = "MMMM d, yyyy";
    private static final String TIME_FORMAT = "hh:mm:ss a";
    private static final String PARTIAL_DATE_TIME_FORMAT = "MMM d, yyyy h:mm:ss a"; // ex: Feb 2, 1990 1:03:05 PM
    private static final String MONTH_YEAR_DATE_FORMAT = "MMMM, yyyy";
    private static final String DATE_DELIMITER = "/";
    
    
    // parses either short date format / partial date time format
    public static synchronized Date parse(String date) {

        SIMPLE_DATE_FORMAT.applyPattern(SHORT_DATE_FORMAT);
        try {
            return SIMPLE_DATE_FORMAT.parse(date);
        } catch (ParseException e1) {
            // most likely the pattern that is being parsed is partial date time format
            SIMPLE_DATE_FORMAT.applyPattern(PARTIAL_DATE_TIME_FORMAT);

            try {
                return SIMPLE_DATE_FORMAT.parse(date);
            } catch (ParseException e2) {
                e2.printStackTrace();
            }
        } catch (NullPointerException ne) {
            // do nothing
        }
        return null;
    }

	// apply short date format
	public static synchronized String shortDateFormat(Date dateToConvert) {
		try {
            SIMPLE_DATE_FORMAT.applyPattern(SHORT_DATE_FORMAT);
			
			return SIMPLE_DATE_FORMAT.format(dateToConvert);
		} catch(Exception e) {
			// do nothing
		}
		
		return StringUtils.EMPTY;		
	}

    // apply date time format
    public static synchronized String dateTimeFormat(Date dateToConvert) {
        try {
            SIMPLE_DATE_FORMAT.applyPattern(DATE_TIME_FORMAT);

            return SIMPLE_DATE_FORMAT.format(dateToConvert);
        } catch(Exception e) {
            // do nothing
        }

        return StringUtils.EMPTY;
    }
    
    // apply date time format
    public static synchronized String dateTimeFormat2(Date dateToConvert) {
        try {
            SIMPLE_DATE_FORMAT.applyPattern(DATE_TIME);

            return SIMPLE_DATE_FORMAT.format(dateToConvert);
        } catch(Exception e) {
            // do nothing
        }

        return StringUtils.EMPTY;
    }
    
    // apply time format
    public static synchronized String timeFormat(Date dateToConvert) {
        try {
            SIMPLE_DATE_FORMAT.applyPattern(TIME_FORMAT);

            return SIMPLE_DATE_FORMAT.format(dateToConvert);
        } catch(Exception e) {
            // do nothing
        }

        return StringUtils.EMPTY;
    }

    // apply full date format
    public static synchronized String fullDateFormat(Date dateToConvert) {
        try {
            SIMPLE_DATE_FORMAT.applyPattern(FULL_DATE_FORMAT);

            return SIMPLE_DATE_FORMAT.format(dateToConvert);
        } catch(Exception e) {
            // do nothing
        }

        return StringUtils.EMPTY;
    }
    
    // apply full date format
    public static synchronized String fullDateFormat2(Date dateToConvert) {
    	try {
    		SIMPLE_DATE_FORMAT.applyPattern(MONTH_YEAR_DATE_FORMAT);
    		Calendar calendar = Calendar.getInstance();
    		calendar.setTime(dateToConvert);
    		return calendar.get(Calendar.DAY_OF_MONTH) + getDayOfMonthSuffix(calendar.get(Calendar.DAY_OF_MONTH)) + " Day of " + SIMPLE_DATE_FORMAT.format(dateToConvert);
    	} catch(Exception e) {
    		// do nothing
    	}
    	
    	return StringUtils.EMPTY;
    }

    public static synchronized Boolean isWeekday(int dayOfWeek) {
        return ((dayOfWeek != Calendar.SATURDAY) && (dayOfWeek != Calendar.SUNDAY));
    }

    static String getDayOfMonthSuffix(final int n) {
    	String suffix = "";
		if (n >= 11 && n <= 13) {
			suffix = "th";
		}
		switch (n % 10) {
			case 1:  suffix = "st";
			case 2:  suffix = "nd";
			case 3:  suffix = "rd";
			default: suffix = "th";
		}
		return suffix;
	}
    
    public static String normalizeExpiryDate(String dateString) throws ParseException{
    	String invalidDateRegex = "(\\d{1,2})/(\\d{1,2})/(\\d{2})";
    	String result = dateString;
    	if(dateString.matches(invalidDateRegex)){
    		String[] datesToParse = dateString.split(DATE_DELIMITER);
    		String month = datesToParse[0];
    		String day = datesToParse[1];
    		String year = normalizeYear(datesToParse[2]);
    		String parsingFormat = buildShortDateFormat(
    				padWithString("M",month.length()),
    				padWithString("d",day.length()),
    				padWithString("y",year.length()));
    		String inputDate = buildShortDateFormat(month,day,year);

    		Date parsedDate = new SimpleDateFormat(parsingFormat).parse(inputDate);
    		result = new SimpleDateFormat(SHORT_DATE_FORMAT).format(parsedDate);
    	}
    	return result;
    }
    
    private static String buildShortDateFormat(String month,String day,String year){
    	StringBuilder builder = new StringBuilder();
    	builder
    	.append(month).append(DATE_DELIMITER)
		.append(day).append(DATE_DELIMITER)
		.append(year);
    	return builder.toString();
    }
    
    private static String normalizeYear(String year){
    	String result = year;
    	if(year.length() == 2){
    		String leadingYear = String.valueOf(Calendar.getInstance().get(Calendar.YEAR)).substring(0,2);
    		result = leadingYear.concat(year);
    	}
    	return result;
    }
    
    private static String padWithString(String padString,int length){
    	StringBuilder result = new StringBuilder();
    	for(int x = 0; x < length ; x++){
    		result.append(padString);
    	}
    	return result.toString();
    }
}