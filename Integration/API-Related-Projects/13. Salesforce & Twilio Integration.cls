Project - Post Data to APIs
Objective: Learn how to send data from Salesforce to an external API.

Challenge:

Integrate Salesforce with the Twilio SMS API.
When a new Opportunity is created, send an SMS notification.
Use a trigger on the Opportunity object to invoke the callout.
Bonus:

Include dynamic data (e.g., Opportunity Name, Amount, or Stage) in the message or SMS.
Create a custom setting to control which Opportunities trigger the integration (e.g., only when Stage = "Closed Won").

Solution:
1.Create Twilio Account
2.Create an Account within Twilio + phone number (here is mine: )
3.then  get your Account SID() and Auth Token()
4.Create Remote Site Setting in Salesforce (https://api.twilio.com)
5.Create Apex Class: 
public with sharing class TwilioIntegration {

    public static void sendSMS(String phoneNumber, String message){
        String accSID = 'yoursid';
        String authToken = 'yourauthtoken';
        String fromNumber = 'twilio_number';
        
        String endpoint = 'https://api.twilio.com/2010-04-01/Accounts/' + accSID + '/Messages.json';
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        String body = 'To=' + EncodingUtil.urlEncode(phoneNumber, 'UTF-8') +
                      '&From=' + EncodingUtil.urlEncode(fromNumber, 'UTF-8') +
                      '&Body=' + EncodingUtil.urlEncode(message, 'UTF-8');
        
        req.setBody(body);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
      
    }
}

6. Create Apex Trigger
trigger OpptyTrigger on Opportunity (after insert) {
    for(Opportunity opp : Trigger.new) {
        // Example: Trigger integration only when Stage is 'Closed Won'
        if (opp.StageName == 'Closed Won') {
            String message = 'Opportunity ' + opp.Name + ' is Closed Won with Amount ' + opp.Amount;
            
            // Post to Slack
            //SlackIntegration.postToSlack(message);
            
            // Or send an SMS via Twilio
            TwilioIntegration.sendSMS('+4156509635', message);
        }
    }

