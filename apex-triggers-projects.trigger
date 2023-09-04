1. Lead Assignment Trigger (Lead Obj)
Use case: Develop a trigger to auto-assign newly generated and existing leads to a support user, based on the business logic. 

trigger LeadAssignMent on Lead (before insert, before update) {
    if(Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert){ 
        for(Lead l : Trigger.new){
            if(l.Industry == 'Banking' && l.Status == 'Open - Not Contacted'){
                l.OwnerId = '0058b00000Hg415AAB';
            }
        }
    }
    if(Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate){
        for(Lead l : Trigger.new){
             if(l.Industry == 'Banking' && l.Status == 'Working - Contacted' && Trigger.oldMap.get(l.id).Industry != 'Banking'){
                l.OwnerId = '0058b00000Hg415AAB';
             }
        }
    }
}


2. Opportunity Stage Automation (Opportunity Obj)
Use case: Develop a trigger that automates the progression of opportunity stages based on specific conditions such as opportunity amount.

trigger OpptyStage on Opportunity (before update) {    
    if(Trigger.isExecuting && Trigger.isbefore && Trigger.isUpdate){
        for(Opportunity o : Trigger.new){
            if(o.Amount == 1000000 ){
                o.StageName = 'Closed Won';
                o.Description = 'Oppty has been closed with an amount of $1M, Good Job '+ o.Owner.Name;
            }
        }   
    }
}


3. Send Email Alert to Oppty Owners (Opportunity Obj)
Use case: Build a trigger that sends email notifications to designated users when  when Amount is => $1M.

trigger SendEmailAlert on Opportunity (after update) {
    Set<ID> bigdealOppties = new Set<ID>();
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
    if(Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate){
        for(Opportunity o : Trigger.new){
            if(o.Amount == 1000002){
                bigdealOppties.add(o.OwnerId);
            }
        }
    }
    List<User> owners = [Select Id, Email, Name from User where Id  in : bigdealOppties];
    
    for(User u : owners){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.toaddresses = new String[] {u.Email};
        mail.setSenderDisplayName('Salesforce Administrator');
        mail.setSubject('Big Deal Alert');
        
        mail.setBccSender(false);
        mail.setSaveAsActivity(false);
        String body = 'Dear, Opportunity Owner';
        body    += 'Your opportunity have generated a more than $1M dollars! Yaay! '+u.Name;
        mail.setHtmlBody(body);
        
        emails.add(mail);
    }
    if(emails.size()>0){
        Messaging.SendEmailResult[] result = Messaging.sendEmail(emails);
        for(Messaging.SendEmailResult sr : result){
            if(!sr.isSuccess()){
                System.debug('There was an error during the email sending process '+ sr.getErrors());
            }
        }
    }
}


4. Auto Populate Email for Contacts (Contact obj)
Use case: if the user doesn't provide an email address, then auto-populate it for them.

trigger AutoPopulateContactEmail on Contact (before insert) {
    if(Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert){
        for(Contact c : Trigger.new){
            if(c.Email == null){
                c.Email = c.FirstName + c.LastName+'@gmail.com';
            }
        }
    }
}


5.Prevent Dup Contact records (Contact obj)
User case: if dup contact is being inserted throw an error to prevent it.

trigger PreventDups on Contact (before insert) {
    Map<String, Contact> emailMap = new Map<String, Contact>();
    Map<String, Contact> phoneMap = new Map<String, Contact>();
    
    
    for(Contact c : Trigger.new){
        if(c.Email != null){
            emailMap.put(c.Email, c);
        }
        if(c.Phone != null){
            phoneMap.put(c.Phone, c);
        }
    }
    
    List<Contact> conList = [Select Id, Email, Phone from Contact where email in: emailMap.keySet() or phone in: phoneMap.keySet()];
    if(conList.size()>0){
        for(Contact c : conList){
            if(emailMap.containsKey(c.Email)){
                c.Email.addError('Contact with this email address already exists!');
            }else{
                emailMap.put(c.Email,c);
            }
            if(phoneMap.containsKey(c.Phone)){
                c.Phone.addError('Contact with this phone number already exists!');
            }else{
                phoneMap.put(c.Phone,c);
            }
        }
    }
}


6. Create Associated Contacts (Account Obj)
Use case: auto-create contacts when accounts are created in the org.

trigger CreateAssociatedContacts on Account (after insert) {
    List<Contact> contactsToCreate = new List<Contact>();
    
    for(Account a : Trigger.new){
        Contact c = new Contact();
        c.LastName = a.Name + ' contact';
        c.AccountId = a.id;
        contactsToCreate.add(c);    
    }
    if(contactsToCreate.size()>0){
        insert contactsToCreate;
    } 
}


7. Send Mass Emails When Lead's created (Lead Obj)
Use case: After a lead is created in the org, auto send emails to the lead owners.

trigger SendEmails on Lead (after insert) {
   Set<ID> leadOwnerId = new Set<ID>();
   List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
    for(Lead l : Trigger.new){
        leadOwnerId.add(l.OwnerId);
    }
	List<User> userList = [Select Id, Email from User where Id in : leadOwnerId];
    Map<ID, String> userMap = new Map<Id,String>();
    
    for(User u : userList){
        userMap.put(u.Id, u.Email);
    }
    for(Lead L : Trigger.new){
        String userEmail = userMap.get(l.OwnerId);
        if(userEmail != null){
            Messaging.SingleEmailMessage mail = new Messaging.singleEmailMessage();
        	mail.toaddresses = new String[] {userEmail};
       		mail.htmlbody = 'New Lead has been created for you';
        	mail.setSubject('Lead assigned to you');
        
        	emails.add(mail);
        }
    }
    Messaging.SendEmailResult[] sr =  Messaging.sendEmail(emails);
    for(Messaging.SendEmailResult r : sr){
        if(!r.isSuccess()){
        	System.debug(r.getErrors());
    	}
    }
    
}


8. Post to Chatter (Case Obj)
Use case: Post a chatter post after the case has been created.

trigger PostToChatter on Case (after insert) {
	List<FeedItem> chat = new List<FeedItem>();
    
    for(Case c : Trigger.new){
        FeedItem cc = new FeedItem();
        cc.ParentId = c.Id;
        cc.Body = 'Case has been create by Aya';
        chat.add(cc);
    }
    if(chat.size()>0){
        insert chat;
    }
}


9. Auto Assign Leads (Lead Obj)
Use case: Auto-assign a Lead to a specific Sales Rep based on the Lead's Industry

trigger AssignLead on Lead (before insert) {
    for(Lead l : Trigger.new ){
        if(l.Industry == 'Banking'){
            l.OwnerId = '0058b00000HmEYhAAN';
        }
    }
}


10. Prevent contact deletion (Account Obj)
Use case: throw an error if user tries to delete existing contact.

trigger PreventConDelete on Account (before delete) {
	Set<ID> accIds = new Set<ID>();
    
    for(Account a : Trigger.old){
        List<Contact> conassociatedwithAccs = [Select Id from Contact where AccountId =: a.Id and Email = 'selenagomez@gmail.com'];
        for(Contact c : conassociatedwithAccs){
            accIds.add(a.id);
        }
    }
    for(Account a : Trigger.old){
        if(accIds.contains(a.id)){
            a.addError('you can not delete contain with email thats selenagomez@gmail.com');
        }
    }


11. Alert Support Team (Case Obj)
Use case: Notify Support Team when High Priority Cases are Created

trigger MoveCases on Case (after insert) {
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
    for(Case c : Trigger.new){
        if(c.Priority == 'High'){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.toaddresses = new String[] {'selenagomez@gmail.com'};
            mail.setSubject('New High Priority Case was created and assigned to you!');
            mail.htmlbody = 'New High Priority Case was created and assigned to you! '+c.Subject;
            emails.add(mail);
        }
    }
    if(emails.size()>0){
        Messaging.sendEmail(emails);
    }
}


12. Auto Assign Cases (Case Obj)
Use case: Assign Case to User Based on Priority

trigger AutoAssignCase on Case (before insert) {
    List<Case> assignCase = new List<Case>();
    
    for(Case c : Trigger.new){
        if(c.Priority == 'High'){
            c.OwnerId = '0058b00000HmEYhAAN';
            assignCase.add(c);
        }
    }
    if(assignCase.size()>0){
        update assignCase;
    }
}


13. Mark Associated Oppties Closed Lost (Account Obj)
Use case: Write a trigger on the Account when the Account is updated check all 
opportunities related to the account. Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from today and stage not equal to close won.

trigger MarkClosedLost on Account (after update) {
	Set<ID> acIds = new Set<ID>();
    List<Opportunity> optieList = new List<Opportunity>();
    
    Date thirtydaysago = Date.today().addDays(-30);
    if(Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate){
        for(Account a : Trigger.new){
            acIds.add(a.id);
        }
    }
    
    if(!acIds.isEmpty()){
        List<Opportunity> relatedOppties = [Select Id, AccountId, StageName,CloseDate from Opportunity where AccountId in : acIds and stageName != 'Closed Won'];
        
          for(Opportunity o : relatedOppties){
        	if(o.StageName != 'Closed Lost' && o.CloseDate > thirtydaysago){
            o.StageName = 'Closed Lost';
            o.CloseDate = date.today();
            optieList.add(o);
        }
    }
}
    
    if(optieList.size()>0){
        update optieList;
    }
}


14. Notify System Administrator
Use case: Once an Account is inserted an email should go to the System Admin user with specified text below.

trigger NotifySystemAdmin on Account (after insert) {
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    User u = [Select Id, Profile.Name, Email from User where Profile.Name = 'System Administrator' and email != null];
    
    if(Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert){
        for(Account a : Trigger.new){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.toaddresses = new String[] {u.Email};
                mail.setSenderDisplayName('System Administrator');
                mail.setSubject('New Account has been created');
                
                String body = 'Dear, System Administrator' + u.Name;
                body+= 'New Account has been created in the system '+a.Name;
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
                System.debug('Error occured while sending emails' + sr.getErrors());
            }
        }
    }
}


15. Update Custom field with Opptie Amount (Account Obj)
Use case: Once an Account will update then that Account will update with the total amount from All its Opportunities on the Account Level. The account field name would be ” Total Opportunity Amount “.

trigger UpdateCustomField on Account (before update) {
    Set<ID> acIds = new Set<ID>();
    Map<Id, Double> amountMap = new Map<Id, Double>();
    
    if(Trigger.isInsert || Trigger.isUpdate){
        for(Account a : Trigger.new){
            a.Total_Amount__c  = 0;
            acIds.add(a.id);
        }
    }
   
    List<AggregateResult> results = [Select AccountId, sum(Amount)total from Opportunity where AccountId in : acIds group by AccountId];
    if(results.size()>0){
         for(AggregateResult a : results){
        	Id accId = (ID)a.get('AccountId');
            Double amount = (Double)a.get('Total');
            amountMap.put(accId, amount);
    	}
    }
    for(Account a :Trigger.new){
         if(amountMap.containsKey(a.id)){
        	a.Total_Amount__c  = amountMap.get(a.id);
    	}  
    }
}


16. Auto-Create Contacts for Newly Inserted Acc (Account Obj)
Use case: Create a field on Account Named (Client Contact lookup to Contact). Once an Account is inserted a Contact will be created with the name of the Account and that Contact will be the Client Contact on the Account.

trigger CreateAssocContact on Account (after insert) {
    List<Contact> conList = new List<Contact>();
    Map<Id, Account> accMap = new Map<Id, Account>();
    
    if(Trigger.isAfter && Trigger.isInsert){
        for(Account a : Trigger.new){
            Contact c = new Contact();
            c.AccountId = a.id;
            c.LastName = a.Name +' contact';
            conList.add(c);
            accMap.put(a.Id, a);
        }
    }
    
    if(conList.size()>0){
        insert conList;
        
            List<Account> accountsToUpdate = new List<Account>();
            
            for (Contact c : conList) {
                Account relatedAccount = accMap.get(c.AccountId);
                
                if (relatedAccount != null) {
                    relatedAccount.Client_Contact__c = c.Id;
                    accountsToUpdate.add(relatedAccount);
                }
            }
            
            if (!accountsToUpdate.isEmpty()) {
                update accountsToUpdate;
            }
    	}   
}


17. Auto - Create an Account (Contact Obj)
Use case: Create Account record whenever new contact is created without an account.

trigger CreateContact on Contact (after insert) {
    List<Account> accList = new List<Account>();
    
    if(Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert){
        for(Contact c : Trigger.new){
            if(c.accountId == null){
                Account a = new Account();
                a.Name = c.LastName;
                a.Phone = c.Phone;
                accList.add(a);
            }
        }
    }
    if(!accList.isEmpty()){
        insert accList;
    }
}


18. Create a field on Account called “Only_Default_Contact”, checkbox, default off (Account Obj)
Use case: When a new Account is created, create a new Contact that has the following data points:
First Name = “Info”
Last Name = “Default”
Email = “info@websitedomain.tld”
Only_Default_Contact = TRUE

trigger CheckIfDefault on Account (after insert) {
    List<Contact> conList = new List<Contact>();
    
    if(Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert){
        for(Account a : Trigger.new){
			Contact c = new Contact();
            c.LastName = 'Default';
            c.FirstName = 'Info';
            c.Email = 'info@websitedomain.tld';
            c.accountId = a.id;
            
            conList.add(c);
            
            a.Only_Default_Contact__c = true;
            update a;
        }
    }
    if(conList.size()>0){
        insert conList;
    }
}


19. Create a field on Account called “ Contact_Created__c ”, checkbox, default off (Contact Obj)
Use case: Create an apex trigger on the contact object and every time a new contact is created and an account is selected in the creation of that contact object then on that account object a checkbox filed ( Contact_Created__c ) will be checked true, which represent that this account has a contact.

trigger CheckContactCreated on Contact (after insert) {
	Set<ID> acIds = new Set<ID>();
    
    if(Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert){
        for(Contact c : Trigger.new){
            acIds.add(c.accountId);
        }
    }
    
    List<Account> acList = [Select Id, Name,Contact_Created__c from Account where Id in : acIds];
    for(Contact c : Trigger.new){
        for(Account a : acList){
            if(a.id == c.AccountId){
                a.Contact_Created__c = true;
            }
        }
    }
    if(acList.size()>0){
        update acList;
    }
}


20. Create a field on Account called “Out_of_Zip”, checkbox, default off (Account Obj)
Use case: When a Billing Address is modified, get the new Postal Code. Then check which Contacts on the Account are outside that Postal Code. If 1 or more Contacts are outside of the Postal Code, mark Out_of_Zip as TRUE.

trigger OutOfZip on Account (before insert, before update) {
    Set<ID> acIds = new Set<ID>();
    
    if(Trigger.isExecuting && Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Integer i=0; i< Trigger.new.size(); i++){
            Account newAcc = Trigger.new[i];
            Account oldAcc = Trigger.old[i];
            
	if(newAcc.BillingCity != oldAcc.BillingCity || newAcc.BillingStreet != oldAcc.BillingStreet || newAcc.BillingPostalCode != oldAcc.BillingPostalCode ||
          newAcc.BillingState != oldAcc.BillingState || newAcc.BillingCountry != oldAcc.BillingCountry){
          acIds.add(newAcc.id);
	
           Map<ID, Integer> acsOutOfZip = new Map<ID, Integer>();
           List<Contact> conList = [Select Id, Account.BillingPostalCode from Contact where Id in : acIds];  
              for(Contact c : conList){
                  if(c.MailingPostalCode != c.Account.BillingostalCode){
                      if(acsOutOfZip.get(c.id) == null){
                          acsOutOfZip.put(c.id, 1);
                      }else{
                          acsOutOfZip.put(c.id, acsOutOfZip.get(c.id)+1);
                      }
                  }
              }
              for(Account a :Trigger.new){
                  if(acsOutOfZip.get(a.id) != null && acsOutOfZip.get(a.id) >1){
                      a.Out_of_Zip = true;
                  }else{
                      a.Out_of_Zip = false;
                  }
              }
        }
    }


21. Update Profile Field (Account Obj)
Use case: Create a field on Contact called Profile, text, 255. When an Account is updated and the Website is filled in, update all the Profile field on all Contacts to:
	Profile = Website + ‘/’ + First Letter of First Name + Last Name

trigger UpdateProfile on Account (after update) {
    Set<ID> acIds = new Set<ID>();
    List<Contact> conList = new List<Contact>();
    
    If(Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate){
        for(Account a :Trigger.new){
            if(a.Website != null){
                acIds.add(a.id);
            }
        }
    }
    
    if(acIds.size()>0){
        List<Contact> conList = [Select Id,AccountId, FirstName,LastName,Account.Website, Profile__c from Contact where AccountId in : acIds];
        for(Contact c : conList){
            if(c.FirstName != null){
                c.Profile__c = c.Account.Website +'/'+c.FirstName.substring(0,1)+c.LastName;
            }
        }
        update conList;
    }
}


22. Mark Gold Opportunities (Account Obj)
Use case: Create a field on Account called “is_gold”, checkbox, default off. When an Opportunity is greater than $20k, mark is_gold to TRUE

trigger GoldOppties on Account (after update) {
    For(Account a:trigger.new){
        List<opportunity> oppList=[select id, Amount, AccountId from opportunity where AccountId =:a.id And Amount > 20000];
        If(oppList.size()>0){
            a.Is_Gold__c=True;
        }Else{
            a.Is_Gold__c=False;
        }
        update a;
    	}
}


23. Mark Need Intel on Acc (Contact Obj)
Use case: Create a field on Account called “need_intel”, checkbox, default off. Create a field on Contact called “Dead”, checkbox, default off. If 70% or more of the Contacts on an Account are Dead, mark the need_intel field to TRUE

//Trigger
trigger UpdateContact on Contact (after update) {
if(Trigger.isUpdate && Trigger.isAfter){
        AccountContact.DeadIntel(Trigger.new);
    }
}

public class DeadIntel {
    public static void updateAccountNeedIntel(List<Contact> conList) {
        Set<Id> accIds = new Set<Id>();
        
        for (Contact c : conList) {
            if (c.AccountId != null) {
                accIds.add(c.AccountId);
            }
        }
        
        Map<Id, List<Contact>> conMap = new Map<Id, List<Contact>>();
        
        for (Contact c : [SELECT Id, AccountId, Dead__c FROM Contact WHERE AccountId IN :accIds]) {
            if (!conMap.containsKey(c.AccountId)) {
                conMap.put(c.AccountId, new List<Contact>());
            }
            conMap.get(c.AccountId).add(c);
        }
        
        List<Account> acListToUpdate = new List<Account>();
        
        for (Id acId : conMap.keySet()) {
            Integer countOfDead = 0;
            Integer totalContacts = conMap.get(acId).size();
            
            for (Contact con : conMap.get(acId)) {
                if (con.Dead__c == true) {
                    countOfDead++;
                }
            }
            
            if (totalContacts > 0 && (countOfDead * 100 / totalContacts) > 70) {
                acListToUpdate.add(new Account(Id = acId, Need_Intel__c = true));
            }
        }
        
        if (!acListToUpdate.isEmpty()) {
            update acListToUpdate;
        }
    }
}


24. Only Sys Admin can Delete Tasks (Task Obj)
Use Case: Write a trigger, only the system admin user should be able to delete the task.

trigger PreventDel on Task (before delete) {
	User u = [Select Id, Profile.Name from User where Profile.Name = 'System Administrator' limit 1];
    for(Task t : Trigger.old){
        if(t.ownerId != u.Id){
            t.addError('Only System Administrator can delete tasks!');
        }
    }
}


25. Recursive Loop Prevention (Lead Obj)
Use case: Create a duplicate lead when a lead is inserted.
trigger CreateDupLeads on Lead (after insert) {
    List<Lead> leadList = new List<Lead>();
    if(Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert){
        if(CheckLeads.dupLead()){
            Lead l = new Lead();
            l.FirstName = 'dup';
            l.LastName = 'dupl';
            l.Company = 'Dup inc.';
            leadList.add(l);
        }   
    }
    if(leadList.size()>0){
        insert leadList;
    }
}

//Apex Class to set the boolean to true, to ensure it runs once and we won't hit the infinite loop
public class CheckLeads {
    private static Boolean r = true;
    public static Boolean dupLead(){
        if(r){
            r = false;
            return true;
        }else{
            return r;
        }
    }
}


26. Auto-create Product Line Items (Opportunity Obj)
Use case: Write a trigger on Opportunity, when an Opportunity will insert an Opportunity Line Item should be insert by default with any of the Products associated with Opportunity.

trigger AutoCreateProductLines on Opportunity (after insert) {
    List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
    if(Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert){
        for(Opportunity o : Trigger.new){
            OpportunityLineItem oli = new OpportunityLineItem();
            oli.opportunityId = o.id;
            oli.Product2Id = '01t8b00000GMJUeAAP';
            oli.PricebookEntryId = '01u8b00000iA3PfAAK';
            oli.Quantity = 23;
            oliList.add(oli);
        }
    }
    if(!oliList.isEmpty()){
        insert oliList;
    }
}


27. Send Mass Email When Acc Type Changes (Account Obj)
Use case: Write a trigger on Account when an account is updated When the account type changes send an email to all its contacts that your account information has been changed.
	  Subject: Account Update Info
	  Body: Your account information has been updated successfully.
	  Account Name: XYZ.

trigger SendMassEmail on Account (after update) {
    Set<ID> acIds = new Set<ID>();
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
    if(Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate){
        for(Account a : trigger.new){
            if(a.Type != Trigger.oldMap.get(a.id).Type && a.Type == 'Prospect'){
                acIds.add(a.id);
            }
        }
    }
    List<Contact> conList = [Select Id, AccountId, FirstName, LastName, Email from Contact where AccountId in :acIds and Email != null];
    
    if(conList.size()>0){
        for(Contact c : conList){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.toaddresses = new String[] {c.Email};
                mail.setSenderDisplayName('Salesforce System Administrator');
                mail.setSubject('You Have a Prospect Account that needs to be contacted and become a customer');
                
                String body = 'Dear, Account Owner '+c.LastName;
                body+= 'your account type has been marked as Prospect, and needs to be contacted to become a customer'; 
                mail.setHtmlBody(body);
                
                mail.setBccSender(false);
                mail.setSaveAsActivity(false);
                
                emails.add(mail);
        }
    }
    if(!emails.isEmpty()){
        Messaging.SendEmailResult[] result = Messaging.sendEmail(emails);
        for(Messaging.SendEmailResult sr : result){
            if(!sr.isSuccess()){
                System.debug('Error occured while sending mass emails '+sr.getErrors());
            }
        }
    }
}













