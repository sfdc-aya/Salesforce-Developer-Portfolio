1. Bulk Data Cleanup (Opportunity obj, Future Method)
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

//to invoke the above class through Anonymous Window:
BatchDataCleanup bc = new BatchDataCleanup();
Database.executeBatch(bc);


2. Send Mass Email Notifications to users when Opptie is closed. (Opportunity obj, Queueable Method)
Use case: Develop a program that sends mass emails to opptie owners when opptie stage is closed won.

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

//to invoke the above class through Anonymous Window:
BulkEmailAlert be = new BulkEmailAlert();
System.enqueueJob(be);


3.Schedule a Data Update (Account Obj, Schedulable Method)
Use case: Update account description when the Industry is Apparel.

global class ScheduleDataUpdate implements Schedulable{
   
    global void execute(SchedulableContext sc){
        List<Account> updateList = [SELECT Id, Description FROM Account WHERE Industry = 'Apparel' LIMIT 100];
        
        if (updateList.size() > 0) {
            for (Account a : updateList) {
                a.Description = 'Apparel account has been updated';
            }
            
            try {
                update updateList;
            } catch (Exception e) {
                System.debug('An error occurred while updating records: ' + e.getMessage());
            }
            
            System.debug('Updated ' + updateList.size() + ' Apparel Accounts.');
        }
    }
}

//to invoke the above class through Anonymous Window:
String cronExp = '0 0 0 * * ?'; 
System.schedule('ScheduledDataUpdate Job', cronExp, new ScheduleDataUpdate());


4.Mass Update Description of an sObject (Opportunity Obj, Future Method)
Use case: Mass Update opptie description when the Stage criteria are met.

public class OpptyHandler {
	
    @future
    public static void markTaskAsCompleted(List<String> statusList ){
        List<Opportunity> opList = [Select Id, StageName, Description from Opportunity where StageName in : statusList];
        for(Opportunity o : opList){
            if(o.StageName == 'Closed Lost'){
                o.Description = 'this oppty was Closed Lost';
                update o;
        	}
        }
    }
}

//to invoke the above class through Anonymous Window:
List<String> statusList  = new List<String>{'Closed Lost'};
OpptyHandler.markTaskAsCompleted(statusList);


5. Assign Permission Sets to Sales Users (User Obj, Future Method)

//Apex Trigger
trigger AssignUserPerm on User (after insert) {
    if(Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert){
        Set<ID> userIds = new Set<ID>();
        
        Profile salesProfile = [Select Id, Profile from Profile where Name = 'Custom: Sales Profile' limit 1];
        
        for(User u : Trigger.new){
            if(u.ProfileId == salesProfile.id){
                userIds.add(u.id);
            }
        }
        if(userIds != null){
            AssignPermission.assignPerm(userIds);
        }
    }
}

//Apex class
public class AssignPermission {
    @future
    public static void AssignPerm(Set<ID> newUsersId){
        PermissionSet salesPermSet = [Select Id from PermissionSet where Name = 'Sales_User_Permissions'];
        
        List<PermissionSetAssignment> permAssign = new List<PermissionSetAssignment>();
        if(salesPermSet != null){
            for(Id userId : newUsersId){
                permAssign.add(new PermissionSetAssignment(PeremissionSetId = salesPermSet.id, AssigneeId = userId));
            }
        }
        if(permAssign != null){
            insert permAssign;
        }
    }
}


6.

