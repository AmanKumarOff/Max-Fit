public class EventAttendeeTriggerHandler {
    public static void AttendeeEmailSend(List<Event_Attendee__c> EventAttendeeNewRecords) {
        List<Messaging.SingleEmailMessage> Emails = new List<Messaging.SingleEmailMessage>();
       
            Set<Id> eventIds = new Set<Id>();
            Set<Id> attendeeIds = new Set<Id>();
            for (Event_Attendee__c eventAttendeeNewRecord : EventAttendeeNewRecords) {
                
                    eventIds.add(eventAttendeeNewRecord.Events__c);
                    attendeeIds.add(eventAttendeeNewRecord.Attendees__c);
            }
            
            Map<Id, Events__c> eventMap = new Map<Id, Events__c>([
                SELECT Name__c, Start__c, 	Location_Address_Book__r.Name, Organizer__r.Name 
                FROM Events__c 
                WHERE Id IN :eventIds
            ]);
            
            Map<Id, Attendees__c> attendeeMap = new Map<Id, Attendees__c>([
                SELECT Name, Email__c 
                FROM Attendees__c 
                WHERE Id IN :attendeeIds]);
        
        for (Event_Attendee__c eventAttendeeNewRecord : EventAttendeeNewRecords) {
           
            
                if (eventAttendeeNewRecord.Events__c == null && eventAttendeeNewRecord.Attendees__c == null) {
                    continue;
                }
    
                    Events__c event = eventMap.get(eventAttendeeNewRecord.Events__c);
                    Attendees__c attendee = attendeeMap.get(eventAttendeeNewRecord.Attendees__c);
                    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(new String[]{attendee.Email__c});
                    email.setSubject('Pass for the "' + event.Name__c + '"');
                    email.setPlainTextBody('Dear ' + attendee.Name + ',\n\nThank you for registering for "' 
                                           + event.Name__c + '" which will be organized on '
                                           + event.Start__c.format('dd/mm/yyyy') + ' and will be held in '
                                           + event.Location_Address_Book__r.Name + '. We are excited to have you, see you at the event.\n\nThanks,\n'
                                           + event.Organizer__r.Name);
                    Emails.add(email);
           
            
        }
        
        try {
            Messaging.sendEmail(Emails);
        } catch (Exception e) {
            ErrorLogRecordingInsert.insertErrorLog(e.getMessage(), 'Error sending email');
        }
        
    }
}