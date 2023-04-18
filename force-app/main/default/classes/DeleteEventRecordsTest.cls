@isTest
public class DeleteEventRecordsTest {
    @testSetup
    public static void testSetupData() {
        List<Events__c> eventList = new List<Events__c>();
        for(Integer i=0; i<=200; i++){
            Events__c event = new Events__c(
                Name__c = 'New Event #'+i+1,
                Event_Type__c = 'Virtual',
                Frequency__c = 'Weekly',
                Max_Seats__c = 199,
                Recurring__c = true,
                Live__c = true,
                Start__c = System.now().addMonths(-4),
                End__c = System.now().addDays(3).addMonths(-4)
            );
            eventList.add(event);
        }
        insert eventList;
        List<Events__c> eventList1 = new List<Events__c>();
        for(Integer i=0; i<200; i++){
            Events__c event = new Events__c(
                Name__c = 'New Event #'+i+1,
                Event_Type__c = 'Virtual',
                Frequency__c = 'Weekly',
                Max_Seats__c = 199,
                Recurring__c = true,
                Live__c = false,
                Start__c = System.now().addMonths(-4),
                End__c = System.now().addDays(3).addMonths(-4)
            );
            eventList1.add(event);
        }
        insert eventList1;
       
    }

    @isTest
    static void sendDeleteEventTest() {
        Test.startTest();
        String jobId = Database.executeBatch(new DeleteEventRecords(), 250);
        Test.stopTest();
        
        List<Events__c> eventlist=[select id, Name from Events__c WHERE Live__c =true AND End__c < LAST_N_MONTHS:2 ];
        System.assertEquals(0,eventlist.size());
        List<Events__c> eventlist1=[select id,Name from Events__c];
        System.assertEquals(200,eventlist1.size());
    }
}