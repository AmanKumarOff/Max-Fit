@RestResource(urlMapping='/v1/EventWebService/')

global class EventWebService {

@httpGet

global static List<EventWrapper> doGetMethod(){

  List<EventWrapper> eventWrappers = new List<EventWrapper>();

    List<Events__c> events = [SELECT Name__c, Start__c, Max_Seats__c,Organizer__r.Name , Organizer__r.Email__c FROM Events__c];

    for (Events__c event : events) {

      EventWrapper eventWrapper = new EventWrapper();

      eventWrapper.event = new Events__c();

      eventWrapper.event.Name__c = event.Name__c;

      eventWrapper.event.Start__c = event.Start__c;

      eventWrapper.event.Max_Seats__c = event.Max_Seats__c;

      eventWrapper.event_organizer = new Event_Organizer__c();

      eventWrapper.event_organizer.Name = event.Organizer__r.Name;

      eventWrapper.event_organizer.Email__c = event.Organizer__r.Email__c;

      eventWrappers.add(eventWrapper);

    }


    return eventWrappers;

  }

  @httpPost

  global static String doPostMethod(String Name, String email, String phone, String company){

    try

    {

    Speaker__c spkr= new Speaker__c(Name =Name, Email__c = email, Phone__c = phone, Company__c = company);

    insert spkr;

    return '200';

    }

    catch(Exception e){

      return '400';

    }

  }

  // Wrapper class for events

  global class EventWrapper {

    global Events__c event;

    global Event_Organizer__c event_organizer;

  }

}