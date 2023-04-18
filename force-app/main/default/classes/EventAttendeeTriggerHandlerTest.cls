@isTest
public class EventAttendeeTriggerHandlerTest {
    
    @isTest
    static void testAttendeeEmailSend() {

        // Create a location record
        Location__c location = new Location__c();
        location.Name = 'Test Location';
        insert location;

         // Create an event record
        Events__c event = new Events__c();
        event.Name__c = 'Test Event';
        event.Start__c = Date.today();
        event.End__c = Date.today().addDays(60);
        event.Location_Address_Book__c = location.Id;
        
        event.Live__c = true; // Set to true to accept attendees
        event.Max_Seats__c = 100;
        insert event;

          // Create an attendee record
        Attendees__c attendee = new Attendees__c();
        attendee.Name = 'Test Attendee';
        attendee.Email__c = 'testattendee@example.com';
        insert attendee;
        // Create an event attendee record
        Event_Attendee__c eventAttendee = new Event_Attendee__c();
        eventAttendee.Events__c = event.Id;
        eventAttendee.Attendees__c = attendee.Id;

        List<Event_Attendee__c> eventAttendeeList = new List<Event_Attendee__c>();
        eventAttendeeList.add(eventAttendee);

        Test.startTest();
        // Call the static method to test it
        EventAttendeeTriggerHandler.attendeeEmailSend(eventAttendeeList);
        Test.stopTest();

        // Verify that the email was sent
        List<EmailMessage> sentEmails = [SELECT Id, ToAddress FROM EmailMessage];
        System.assertEquals(1, sentEmails.size());
        System.assertEquals('testattendee@example.com', sentEmails[0].ToAddress);
    }
}