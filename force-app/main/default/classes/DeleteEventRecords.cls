public with sharing class DeleteEventRecords implements Database.Batchable<SObject>  {
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String query = 'Select id from Events__c where Live__c = true AND End__c < LAST_N_MONTHS:2';
        return Database.getQueryLocator(query);

    } 

    public void execute(Database.BatchableContext batchContext, List<Events__c> listEvt){
         delete listEvt;
        }
    

    public void finish(Database.BatchableContext batchContext){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setSubject('Batch has been processed');
        List<String> toAddress = new List<String>();
        toAddress.add('aman.kumar@mirketa.com');
        mail.setToAddresses( toAddress );
        mail.setSenderDisplayName('Organizer');
        
        mail.setHtmlBody('The records have been deleted.');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(emails);
    }
}