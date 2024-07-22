package net.ipc.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 */
public class JsonUtil {
//    ' - , /
    private static final String JSON_STRING = "\"(\\w+)\":[\"]?([\\w\\d\\s\\Q_,!@#%.^&*()-+\\E/]*)?[\"]?,?";
    private static final String JSON_STRING_NEW_LINE = "\"(\\w+)\":[\"]?([\\w\\d\\s\\Q_\\,\'!@#%.^&*()-+\\E/]*)?[\"]?,?";
//    private static final String JSON_STRING_NEW_LINE = "\"(\\w+)\":[\"]?([a-zA-Z0-9'/~@#\\^\\$&\\*\\(\\)-_\\+=\\[\\]\\{\\}\\|\\\\,\\.\\?\\s]*)?[\"]?,?";
    private static final int PROPERTY = 1;
    private static final int VALUE = 2;

    private JsonUtil(){
        //do not instantiate. Util class
    }

    public static Map<String,String> parseToMap(String jsonString){
        Map<String,String> jsonMap = new HashMap<String,String>();
        Matcher matcher = Pattern.compile(JSON_STRING).matcher(jsonString);
        while(matcher.find()){
            jsonMap.put(matcher.group(PROPERTY),matcher.group(VALUE));
        }
        return jsonMap;
    }

    public static Map<String,String> parseToMapNewLine(String jsonString){
        Map<String,String> jsonMap = new HashMap<String,String>();
        Matcher matcher = Pattern.compile(JSON_STRING_NEW_LINE).matcher(jsonString);
        while(matcher.find()){
            System.out.println("matcher.group(VALUE) " + matcher.group(VALUE));
            jsonMap.put(matcher.group(PROPERTY),matcher.group(VALUE));
        }
        return jsonMap;
    }

}
