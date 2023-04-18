public with sharing class AttendeeRegistrationController {
    public Attendees__c att {get;set;}
    public Event_Attendee__c  evtAttendee{get;set;}
    public Location__c loc {get;set;}
    public String mstrId;
    public AttendeeRegistrationController() {
        mstrId = ApexPages.currentpage().getParameters().get('param1');
        att= new Attendees__c();
        evtAttendee = new Event_Attendee__c();
        loc=  new Location__c ();
        evtAttendee.Events__c = mstrId;
    }
    public PageReference save(){
    insert loc;
    att.Location_Address_Book__c=loc.Id;
    insert att;
    evtAttendee.Attendees__c= att.Id;
    insert evtAttendee;
    return new PageReference('/apex/AttendeeRegistrationController').setRedirect(true);
    }
}