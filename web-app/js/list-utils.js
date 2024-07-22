/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/30/12
 * Time: 12:40 AM
 * To change this template use File | Settings | File Templates.
 */

// converts string to list of hashmap from server
// string is constructed using ParserService.listHashMapToString
function stringToListHashMap(stringValue) {
    // formats string to json format
    stringValue = '[' + stringValue.replace(/\[/g,'{').replace(/\]/g,'}').replace(/=/g,':')
        .replace(/"\s/g,'", ').replace(/{(.+?):/g,'{"$1":')
        .replace(/;/g,',\r\n') + ']';

    var listHashMap = eval(stringValue);

    return listHashMap;
}
