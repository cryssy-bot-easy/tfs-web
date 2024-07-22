/**
(New)
SCR/ER Number: 20170510-057
SCR/ER Description: Encounter error 500 or unending loading screen when the idle timeout (15 minutes) was reached and try to click view MT or click the charges tab.
[Revised by:] Jesse James Joson
[Date deployed:]
Program [Revision] Details: new javascript that will count upto 15 mins. and restart counting every time the header was initialized then if the count reaches idle timeout it will call logoutUrl to execute the force logout function in LoginController.groovy.
Member Type: Javascript 
Project: WEB
Project Name: login.js
 */

$(function here(){
	var stopRequest = false;
	var URL = startTimerUrl;
	var sec = 0;
	var min = 0;
	
	console.log(URL);
	
	
	var timer = setInterval(function() {
		
				if(stopRequest == true){
					$.getJSON(URL,function(data) {
						console.log("User group: " + data.role);
						
						if (data.role != "BATCH") {
							console.log(data.message);
							sec = 0;
							min = 0;
							console.log("Force Logout1: ");
							clearInterval(timer);
							forceLogout();
						} else {
							clearInterval(timer);
							return 0;
						}
					});				
				} else if (sec == 0 && min == 0) {
					$.getJSON(URL,function(data) {
						console.log("User group: " + data.role);						
						if (data.role == "BATCH") {
							clearInterval(timer);
							return 0;
						} 
					});	
				}
		
				if (sec == 60) {
					sec = 0;
					min++;
				}
				
				if(sec == 0){
					console.log("minutes: " + min);
				}
				
				console.log("timer started... ");
				sec++;
				
				if((sec == 1 || sec == 30) && min >= 15){
					$.getJSON(URL,function(data) {
						console.log("User group: " + data.role);						
						if (data.success == false) {
							console.log(data.message);
							sec = 0;
							min = 0;
							console.log("Force Logout2: ");
							clearInterval(timer);
							forceLogout();
						} else if (data.min == 15) {
							console.log(data.message);
							sec = 0;
							min = 0;
							console.log("Force Logout3: ");
							clearInterval(timer);
							forceLogout();
						} else if (data.success == true) {
							min = data.min;
							sec = data.sec;
							console.log("minutes: " + min + "  seconds: " + sec);
						}
					});	
				}
		
	}, 1000);   
	
})

function forceLogout(){
	var URL = logoutUrl;
	test = "FORCED";
	URL = URL + "?message=Your current login session has expired."
	
	location.href=URL;
	
}
