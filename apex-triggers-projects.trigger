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


12. Auto Assign Cases
//Assign Case to User Based on Priority
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


















