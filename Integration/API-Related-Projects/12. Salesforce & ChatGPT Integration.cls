
Remote site setting: 	https://api.openai.com
Apex class ChatGPTIntegration:

public class ChatGPTIntegration {
    @AuraEnabled(cacheable=false) // This annotation exposes the method to LWC
    public static String getChatGPTResponse(String userInput) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.openai.com/v1/completions');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer API KEY'); // Replace with your API key
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"model": "gpt-3.5-turbo", "messages":[{"role":"system","content":"You are a helpful assistant."}, {"role":"user","content":"'+ userInput + '"}]}');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        if(res.getStatusCode() == 200) {
            String responseBody = res.getBody();
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
            List<Object> choices = (List<Object>) jsonResponse.get('choices');
            Map<String, Object> message = (Map<String, Object>) choices[0];
            return (String) message.get('message');
        } else {
            return 'Error: ' + res.getStatusCode();
        }
    }
}
