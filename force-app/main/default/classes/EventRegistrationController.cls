public with sharing class EventRegistrationController {

    public Event_Organizer__c evtOrganizer {get;set;}
	public Events__c evt {get;set;}
	public Location__c	 loc {get;set;}

	public EventRegistrationController ()
	{
		evtOrganizer = new Event_Organizer__c();
		evt = new Events__c();
		loc = new Location__c();
	}
	public PageReference save() 
	{
		// insert con;
		if(evt.Event_Type__c!='Virtual'){
		insert loc;
        evtOrganizer.Address__c = loc.Id;
		
		insert evtOrganizer;
        evt.Organizer__c = evtOrganizer.Id;
		evt.Location_Address_Book__c= loc.Id;
		insert evt;}
		else{
			insert evtOrganizer;
        evt.Organizer__c = evtOrganizer.Id;
		// evt.Location_Address_Book__c= loc.Id;
		insert evt;
		}
		return new PageReference('/apex/EventRegistrationController').setRedirect(true);
	}
}