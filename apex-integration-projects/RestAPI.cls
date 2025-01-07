1. Challenge: Rest Api Authentication through Postman.
Solution: 

Sfdc side:
-I created a Connected App under App Manager
-Gave it a Name, Provided email address, Enabled OAuth Setting (under API), Callback URL: https://localhost, Selected Full access, and Perform requests at any time(refresh token, offline_access) under Selected OAuth Scopes
-Once saved, it generated a new Consumer Key and Consumer Secret

Postman side:
-Created a RestAPI Collection, then added a request for RestAPI Authentication
-Method: Post
-Endpoint: https://login.salesforce.com/services/oauth2/token
-Headers: 
      Authorization: Bearer <Security_Token>
      Content-Type: application/x-www-form-urlencoded
-Body:
      Grant_Type: password
      Client_Id
      Client_Secret
      Username
      Password: <passwordSecurityToken>

-Send Request: 
      Status Code 200 Ok, AccessToken, instanceUrl is received back.


2. Create a REST API endpoint to retrieve Account records, returning names and phone numbers.
Solution: 
Based on the request above, I received the Access token, and instanceUrl that I was able to use to complete the second challenge.

Postman side:
-Method: Get
-Endpoint: <InstanceUrl>/services/data/v52.0/sobjects/Account/<AccountId>
-Body: none

-Send Request: 
      Status Code 200 Ok, received details on the Account record passed.


3. Apex REST Endpoint to get the specific Contact
Solution:

Sfdc side:
-Create Apex RestResource Annotated class

@RestResource(urlMapping='/contact/')
global with sharing class ContactAPi {
    @HttpGet
    global static Contact getContact() {
        RestRequest req = RestContext.request;
        String contactId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        return [SELECT Id, Name, Email FROM Contact WHERE Id = :contactId LIMIT 1];
    }
}

Postman side:
-Method: Get
-Endpoint: <instanceUrl>/services/apexrest/contact/<ContactID>
-Headers: 
   Authorization: Bearer <SecurityToken>
   ContentType: application/json


4. Apex REST Endpoint to get the specific Opportunity
Solution:

Sfdc side:
-Create Apex RestResource Annotated class

Postman side:
-Method: Get
-Endpoint: <instanceUrl>/services/apexrest/contact/<ContactID>
-Headers: 
   Authorization: Bearer <SecurityToken>
   ContentType: application/json


@RestResource(urlMapping='/opportunity/')
global with sharing class OpportunityApi {
    @HttpGet
    global static Opportunity getOpportunity(){
        RestRequest req = RestContext.request;
        String oppId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        return [SELECT Id, Name, Amount, StageName, CloseDate, OwnerId, Type, LeadSource FROM Opportunity WHERE Id =:oppId LIMIT 1];
    }
}


5.Call a Public API from Salesforce using Rest API Callouts to generate random jokes.
Solution: 

Sfdc side:
-Created Remote Site Setting, and included the Name and Remote Site URL
-Then Created an Apex Rest API Callout to call the public API to fetch random jokes.
-Then Called this class and method name using Anonymous Window in Dev Console.

Note: Api key and URL endpoint can be found on the account of the public API website.

public class JokeAPIService{
 public static void fetchRandomJoke(){
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
           // String apiKey = 'ef3df01b00021fae86fda6a2074a9f40';
            String endPoint = 'https://official-joke-api.appspot.com/random_joke';
            
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            
            if(response.getStatusCode()==200){
            Map<String, Object> jsonResponse = (Map<String, Object>) Json.deserializeUntyped(response.getBody());
            //System.debug('Weather API Response'+ response.getBody());
            
            String setup =(String)jsonResponse.get('setup');
            String punchLine=(String)jsonResponse.get('punchline');
            System.debug('Here is a joke for you: ');
            System.debug('Setup: '+ setup);
            System.debug('PunchLine: '+punchLine);
            
            }else{
              System.debug('Error: HTTP Status Code' + response.getStatusCode());
            }
        }catch(Exception e){
             System.debug('Exception:'+e.getMessage());
        }
     }
}











