@isTest
public class ErrorLogDetailsTest {
    @isTest
    static void insertLogTest() {
        Test.startTest();
        // Test inserting a new error log record
        String processName = 'Process 1';
        String details = 'Error occurred during processing';
        ErrorLogRecordingInsert.insertErrorLog(details, processName);
        // Verify that the error log record was created
        List<Error_Log__c> logs = [SELECT Process_Name__c, Log__c, Log_Details__c FROM Error_Log__c WHERE Process_Name__c = :processName];
        System.assertEquals(1, logs.size());
        Error_Log__c log = logs[0];
        System.assertEquals(processName, log.Process_Name__c);
        System.assertEquals(details, log.Log_Details__c);
        Test.stopTest();
    }
}