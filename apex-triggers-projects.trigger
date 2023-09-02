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




















