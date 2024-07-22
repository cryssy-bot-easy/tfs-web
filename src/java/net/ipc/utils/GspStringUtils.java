package net.ipc.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;
import java.util.regex.*;

import org.apache.commons.lang.StringUtils;

public class GspStringUtils {
	
	private static final String EMPTY = "";
	
	public static synchronized boolean isNotEmpty(Object... objects){
		boolean result = false;
		
		for(Object obj: objects){
			if(!getStringValue(obj).equals(EMPTY)){
				result=true;
			}
		}
		
		return result;
	}
	
	public static synchronized String getExistingValue(Object... objects){
		String result = EMPTY;
		String temp;
		
		for(Object obj: objects){
			temp = getStringValue(obj); 
			if(!temp.equals(EMPTY)){
				result = temp;
				break;
			}
		}
		
		return result;
	}
	
	
	private static String getStringValue(Object obj){
		if(obj != null){
			return obj.toString().trim();
		}else{
			return EMPTY;
		}
	}
	
	@Deprecated
	public static synchronized String getExistingBank(Object bankTo,Object bankFrom) {
		String result=StringUtils.EMPTY;
		try{
			if(bankTo != null && !StringUtils.isBlank(bankTo.toString())){
				result=bankTo.toString();
			}else if(bankFrom != null && !StringUtils.isBlank(bankFrom.toString())){
				result=bankFrom.toString();
			}
		}catch(Exception e){
			//do nothing
		}
		return result;
	}
	public static synchronized Integer getNumberOfViews(String Desc, String SpecialBenif, String SpecialBank, List<String> requiredDocument, List<String> additionalCondition){
		int sequenceNumber, longest;

			String[] DescLines = Desc.split("\r\n");
			String[] SpBenifLines = SpecialBenif.split("\r\n");
			String[] SpBankLines = SpecialBank.split("\r\n");
			String[] requiredDocumentLines = formatMultiLine(requiredDocument).split("\r\n");
			String[] additionalConditionLines = formatMultiLine(additionalCondition).split("\r\n");
			
			Integer[] fieldList = {DescLines.length, SpBenifLines.length, SpBankLines.length, requiredDocumentLines.length, additionalConditionLines.length};
			Arrays.sort(fieldList);
			longest = fieldList[4];
			
			sequenceNumber = longest / 100;
			if(longest % 100 > 0) { sequenceNumber =  sequenceNumber + 1; }
			
		return sequenceNumber - 1;
	}
	public static synchronized Integer getNumberOfViewsAmendment(String Desc, String SpecialBenif, String SpecialBank, String requiredDocument, String additionalCondition){
		int sequenceNumber, longest;

			String formattedRequiredDocument = formatMultiLineAmendment(requiredDocument);
			String formattedAdditionalCondition = formatMultiLineAmendment(additionalCondition);

			String[] DescLines = Desc.split("\r\n");
			String[] SpBenifLines = SpecialBenif.split("\r\n");
			String[] SpBankLines = SpecialBank.split("\r\n");
			String[] requiredDocumentLines = formattedRequiredDocument.split("\r\n");
			String[] additionalConditionLines = formattedAdditionalCondition.split("\r\n");
			
			Integer[] fieldList = {DescLines.length, SpBenifLines.length, SpBankLines.length, requiredDocumentLines.length, additionalConditionLines.length};
			Arrays.sort(fieldList);
			longest = fieldList[4];
			
			sequenceNumber = longest / 100;
			if(longest % 100 > 0) { sequenceNumber =  sequenceNumber + 1; }
			
		return sequenceNumber - 1;
	}
    public static String formatMultiLine(List<String> sourceString){
		if(sourceString != null || !sourceString.equals(EMPTY)){
			StringBuilder sb = new StringBuilder();
			for(String listoDesuList : sourceString){
				if(listoDesuList.contains("<br>") || listoDesuList.contains("/n") || listoDesuList.contains("<br/>") || listoDesuList.contains("<BR>") || listoDesuList.contains("/N") || listoDesuList.contains("<BR/>")|| listoDesuList.contains("\r")|| listoDesuList.contains("\n")|| listoDesuList.contains("\r\n")) {					
					String[] StringtoArray = ("+"+listoDesuList).split("(/N)|(<BR>)|(<BR/>)|(/n)|(<br>)|(<br/>)|(\r)|(\n)|(\r\n)|(\\r)|(\\n)|(\\r\\n)");
		            for(int i =0; i < StringtoArray.length; i++){
		                sb.append(StringtoArray[i]).append("\r\n");
		            }
				} else if(!listoDesuList.contains("\r\n")){
					String[] StringtoArray = ("+"+listoDesuList).split("(?<=\\G.{65})");
		            for(int i =0; i < StringtoArray.length; i++){
		                sb.append(StringtoArray[i]).append("\r\n");
		            }
				} else {sb.append("+").append(listoDesuList).append("\r\n");}
			}
			return sb.toString();
		}
		return "";
    }
    public static String formatMultiLineAmendment(String sourceString){
		if(sourceString != null || !sourceString.equals(EMPTY)){
			StringBuilder sb = new StringBuilder();
	        List<String> lines = Arrays.asList(sourceString.replace("|", "\r\n").split("\r\n"));
	        for(String perList : lines){
	            for (int i = 0; i < perList.length(); i++) {
	                if (i > 0 && (i % 65 == 0)) {
	                	sb.append("\r\n");
	                }
	                sb.append(perList.charAt(i));
	            }
	            sb.append("\r\n");
	        }
	        return sb.toString();
		}
		return "";
    }
}
