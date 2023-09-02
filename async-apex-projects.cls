1. Bulk Data Cleanup (Opportunity obj)
Use case: delete all Closed Won Oppties from the system using async apex

public class BatchDataCleanup implements Database.Batchable <sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id, StageName from Opportunity');
    }
    public void execute(Database.BatchableContext bc, List<Opportunity> scope){
        List<Opportunity> todeleteList = new List<Opportunity>();
        
        for(Opportunity o : scope){
            if(o.StageName == 'Closed Won'){
                todeleteList.add(o);
            }
        }
        if(todeleteList.size()>0){
            delete todeleteList;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch job is done.');
    }
}


2. Send Mass Email Notifications or alerts to users or stakeholders when Opptie stage is closed Won.
Use case: 

public class BulkEmailAlert implements Queueable{
    List<Opportunity> opList;
    
    public BulkEmailAlert(List<Opportunity> opp, List<User> user){
        opList = opp;
    }
    
    public void execute(QueueableContext qc){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Map<Id, String> ownerEmails = new Map<Id, String>();
        
        for(Opportunity o : opList){
            ownerEmails.put(o.OwnerId, null);
        }
        
        List<User> userList = [Select Id, Email from User where Id in : ownerEmails.keySet()];
        for(User u : userList){
            ownerEmails.put(u.id, u.Email);
        }
        
        for(Opportunity o : opList){
            if(o.StageName == 'Closed Won' && ownerEmails.containsKey(o.OwnerId)){
            	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            	mail.toaddresses = new String[] {ownerEmails.get(o.OwnerId)};
                mail.setSenderDisplayName('Salesforce Administrator');
            	mail.setSubject('Your Opportunity has been closed');
            	String body = 'Dear, Oppty Owner '+ o.OwnerId;
            	body+= 'Your oppty has been closed Won!';
            	mail.setHtmlBody(body);
            	
            	mail.setSaveAsActivity(false);
            	mail.setBccSender(false);
            	
            	emails.add(mail);
        	}
        }
        if(emails.size()>0){
            Messaging.SendEmailResult[] result = Messaging.sendEmail(emails);
            for(Messaging.SendEmailResult sr : result){
                if(!sr.isSuccess()){
                    System.debug('Error occured while processing emails '+sr.getErrors());
                }
            }
        }
    }
}

