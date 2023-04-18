trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) {
    Set<Id> eventId = new Set<Id>();
    Set<Id> speakerId = new Set<Id>();
    for(Event_Speaker__c evtSpkr: Trigger.new){
        eventId.add(evtSpkr.Events__c);
        speakerId.add(evtSpkr.Speaker__c);
    }
    Map<Id,Events__c> evtDateTime= new Map<Id, Events__c>([Select id, Start__c, End__c from Events__c where id in :eventId]);
    List<Event_Speaker__c> spkr = [Select id, Events__c,Speaker__c,Events__r.Start__c, Events__r.End__c from Event_Speaker__c where Speaker__c in :speakerId];
    for(Event_Speaker__c evtSpkr: Trigger.new){
        Events__c evtTime = evtDateTime.get(evtSpkr.Events__c);
        Datetime evtTimeStart = evtTime.Start__c;
        Datetime evtTimeEnd = evtTime.End__c;
        for(Event_Speaker__c checkEvtSpkr: spkr){
            if(evtSpkr.Speaker__c == checkEvtSpkr.Speaker__c && ((evtTimeStart <= checkEvtSpkr.Events__r.Start__c && evtTimeEnd >= checkEvtSpkr.Events__r.End__c) ||(evtTimeStart >= checkEvtSpkr.Events__r.Start__c && evtTimeStart <= checkEvtSpkr.Events__r.End__c ) ||(evtTimeEnd >= checkEvtSpkr.Events__r.Start__c && evtTimeEnd <= checkEvtSpkr.Events__r.End__c)))
            {
                evtSpkr.Speaker__c.addError('Already booked');
                evtSpkr.addError('Already Booked');
            }
        
    }
}

}