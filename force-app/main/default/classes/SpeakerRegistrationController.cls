public with sharing class SpeakerRegistrationController {

    public Speaker__c spk{get;set;}
    public Event_Speaker__c espk{get;set;}
    //public Events__c evt{get;set;}
    public String mstrId;
    

    public SpeakerRegistrationController() {
        mstrId = ApexPages.currentpage().getParameters().get('param1');
        spk=new Speaker__c();
        espk=new Event_Speaker__c();
        //evt=new Events__c();
        espk.Events__c=mstrId;
    }
    public PageReference save() 
	{
    	insert spk;
        espk.Speaker__c=spk.ID;
        
        insert espk;
       
       
       
		return new PageReference('/apex/SpeakerRegistrationController').setRedirect(true);
	}
}