public with sharing class ErrorLogRecordingInsert {
    public static void insertErrorLog(String logDetails, String processName ) {
        Error_log__c errorlog= new Error_log__c();
        errorlog.Log_DateTime__c=Datetime.now();
        errorlog.Log_Details__c=logDetails;
        errorlog.Process_Name__c=processName;
        insert errorlog;
    }
}