@RestResource (urlmapping='/welcome/*')
global with sharing class WelcomeRestService {
   
    @HttpGet
    global static String getWelcomeMessage(){
        return 'Welcome to the Salesforce Rest API';
    }

}