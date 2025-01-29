2.1. Project - Post Opportunity Stage Updates to Slack Channel with the help of Salesforce and Slack Webhooks Integration
Objective: Learn how to send data from Salesforce to an external API.

Challenge:

Integrate Salesforce with Slack Webhooks.
When a new Opportunity is created, post a message to a Slack channel or send an SMS notification.
Use a trigger on the Opportunity object to invoke the callout.

Solution:
Created Slack Workspace (Aya Inc.)
Add Incoming Webhooks App
then got the Webhooks URL from the Incoming Webhooks App
then created a channel in my Workspace and added this channel to Incoming Webhooks App
then created the Remote Site Settings: https://hooks.slack.com (SlackWebhook)
then created the Apex Future Callout Class:

public class SlackIntegration {

    @future (callout=true) // This marks the method as async and allows the callout
    public static void postToSlackAsync(String message) {
        String slackWebhookUrl = 'https://hooks.slack.com/services/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';
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(slackWebhookUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        
        String payload = '{"text": "' + message + '"}';
        req.setBody(payload);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        System.debug('Response Status Code: ' + res.getStatusCode());
        System.debug('Response Body: ' + res.getBody());
    }
}

then Created the Apex Trigger on the Opportunity Object:

trigger OpportunityTrigger on Opportunity (after insert, after update) {
    for(Opportunity opp : Trigger.new) {
        System.debug('Opportunity Trigger is firing for: ' + opp.Name);
        if (opp.StageName == 'Closed Won') {
            String message = 'Opportunity ' + opp.Name + ' is now Closed Won with an Amount of ' + opp.Amount;
            System.debug('Sending message to Slack: ' + message);
            SlackIntegration.postToSlackAsync(message);
        }
    }
}

then tested an Oppty to set the stage to Closed Won
and I got the notification in my Slack channel



2.2. Project - When Account Type = 'Prospect' & Industry = 'Healthcare' send this account details to the Slack Channel with the help of Salesforce and Slack Webhooks Integration
Objective: Learn how to send data from Salesforce to an external API.

Challenge

Integrate Salesforce with Slack Webhooks.
When a new Opportunity is created, post a message to a Slack channel.
Use a trigger on the Opportunity object to invoke the callout.

Solution: 
Created a new channel within the same Slack channel (Aya Inc.)
Using the above Remote Site Setting as once you specify the URL no repetitive duplications are needed

Then created Async Apex Future Callout class:

public with sharing class SlackAccountIntegration {
	@future(callout=true)
    public static void postAccountUpdatesToSlack(String message){
        String webHookUrl = 'https://hooks.slack.com/services/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';
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(webHookUrl);
        req.setmethod('POST');
        req.setHeader('Content-Type', 'application/json');
        
        String payload = '{"text":" ' + message + '"}';
        req.setBody(payload);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        System.debug('Response failed'+ res.getStatusCode());
    }
}

Created AccountTrigger for the above logic in the requirements:

trigger AccountTrigger on Account (after insert, after update) {
    if(Trigger.isInsert && Trigger.isAfter || Trigger.IsUpdate && Trigger.IsAfter){
        for(Account a : Trigger.new){
            if(a.Industry == 'Healthcare' && a.Type == 'Prospect'){
                String message = 'Account '+a.Name+' created with Type = '+ a.Type+' and Industry = '+a.Industry+'. Please reach prioritize this Account and schedule a call with the customer ASAP, Thanks! ';
            	System.debug('Sending message to Slack '+ message);
                SlackAccountIntegration.postAccountUpdatesToSlack(message);
            }
        }
    }
}

