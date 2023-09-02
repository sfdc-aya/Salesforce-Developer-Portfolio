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



