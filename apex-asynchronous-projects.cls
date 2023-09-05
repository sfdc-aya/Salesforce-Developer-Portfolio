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


3. Schedule a Data Update (Account Obj, Schedulable Method)
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


4. Mass Update Description of an object (Opportunity Obj, Future Method)
Use case: Mass Update option description when the Stage criteria are met.

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
Use case: Pre-requisite: Create a permission set with the API name Sales_User_Permissions.
	  Whenever a new user is created with the profile Custom: Sales Profile, assign the permission set Sales_User_Permissions to the User.
	  Consider this not urgent and permission set can be assigned when the resource is available in salesforce org. Use @future annotation for the method that contains the logic.

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

//Test Class
Scenario 1- Create a new user with profile “Custom: Sales Profile”. Verify that after insertion of the user, a permission set assignment record should be created with ‘Sales_User_Permissions’ permission set and inserted User as the assignee.

@isTest
public class TestUserUtil {
    
    @isTest
    public class createUser(String fName, String lName, String Alias, Profile profile){
        User us = new User(firstName = fName, lastName = lName, Alias = alias,email = fName+'.'+lName+'@apexbabysteps.com', profileId = profile);
        return us;
        }
    }

	@isTest
    private class UsrTrigger{
      @isTest
        static void testProfile(){
            Profile profile = [Select Id from Profile where name = 'Custom: Sales Profile' limit 1];
            User usr = TestUserUtil.createUser('Test','User222', 'tusr', profile);
            
            Test.startTest();
            	insert usr;
            Test.stopTest();
            
            PermissionSet ps = [Select Id from PermissionSet where Name = 'Sales_User_Permissions' limit 1];
            List<PermissionSetAssignment> psa = [Select Id from PermissionSetAssignment where permissionsetid = :ps.id and assigneeId = :usr.Id];
            System.assertEquals(1, ps.size(), 'Permission set records are not as expected');
        }
    }

	@isTest
    public static void test_diff_user(){
        Profile profile = [Select Id from Profile where Name = 'Standard User' Limit 1];
        User usr = TestUserUtil.createUser('Test2', 'User333', 'tus', profile);
        
        Test.startTest();
        	insert usr;
        Test.stopTest();
        
        PermissionSet ps = [Select Id from PermissionSet where Name = 'Sales_User_Permissions' limit 1];
        List<PermissionSetAssignment> psa = [Select Id from PermissionSetAssignment where permissionSetId =: ps.Id and assigneeId =: usr.Id];
        System.assertEquals(0, ps.size(), 'Permission set records are not as expected');
    }
}


6. Update Contacts (Contact Obj, Batch Method)
Use case: Description of Contact should be updated with “Title of AccountName: Account’s Description“. Contact which does not have any Account associated with it, should not be updated.

public class UpdateContact implements Database.Batchable <sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select AccountId, Title, Account.Name, Account.Description, Id from Contact where AccountId != null');
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        if(scope != null){
            for(Contact c : scope){
            	c.Description = c.title +' of '+c.Account.Name+':'+c.Account.Description;
        	}
            update c;
        }      
    }
    public void finish(Database.BatchableContext bc){
        System.debug('The job is finished');
    }
}
//to invoke
UpdateContactDescription bc = new UpdateContactDescription()
Database.executeBatch(bc);


7. Assign Tasks Asynchronously (Opportunity Obj, Batch Method)
Use case: Create a Task to review opportunities for all the opportunities irrespective of their StageName. Tasks should be assigned to the related Opportunity Owner and if 
	  any of the Owner/User is inactive then assign the task to any user with a profile System Administrator.

public class AssignTasks implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id,OwnerId, Owner.isActive from Opportunity');
    }
    public void execute(Database.BatchableContext bc, List<Opportunity> scope){
        List<Task> tasks = new List<Task>();
        User usr = [Select Id from User where Profile.Name = 'System Administrator' limit 1];
        
        for(Opportunity o : scope){
            String owner;
            if(o.Owner.isActive){
                tasks.add(new Task(whatid = o.id, whoId = o.ownerId, subject = 'Please review the related oppties'));
            }else{
                tasks.add(new Task(whatId = o.id, whoid = usr.id, subject = 'Please review related oppties'));
            }
        }   
        insert tasks;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Job is completed!');
    }
}


8.

