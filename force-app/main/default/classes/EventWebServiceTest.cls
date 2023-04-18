@isTest
public with sharing class EventWebServiceTest {

    static testMethod void testGetMethod() {

        Events__c evt = new Events__c();

        Event_Organizer__c evtOrg = new Event_Organizer__c();

        evt.Name__c = 'Test Event Web Service 1';

        evt.Start__c = datetime.newInstance(2024, 9, 15, 12, 30, 0);

        evt.Max_Seats__c = 50;

        evtOrg.Name = 'Test Event Organizer Web Service 1';

        evtOrg.Email__c = 'abc@abc.com';

        insert evtOrg;

        evt.Organizer__c = evtOrg.Id;

        insert evt;

        RestRequest req = new RestRequest();

        req.requestURI='/services/apexrest/v1/EventWebService/';

        req.httpMethod='Get';

        RestContext.request = req;

        Test.startTest();

        List<EventWebService.EventWrapper>  evnt = EventWebService.doGetMethod();

        Test.stopTest();

        System.assert(evnt!=null);

        System.assertEquals('Test Event Web Service 1', evnt.get(0).event.Name__c);
    }

    static testMethod void testPostMethod(){

        RestRequest req = new RestRequest();

        req.requestUri ='/services/apexrest/v1/EventWebService/';

        req.httpMethod = 'POST';

        RestContext.request = req;

        Test.startTest();

        String strId = EventWebService.doPostMethod('Event Organizer Web Service Test 1','p@p.com','123884245','comp');

        String strId2 = EventWebService.doPostMethod('Event Organizer Web Service Test 1','pk','123884245','comp');

        Test.stopTest();

        System.assertEquals('200', strId);

        System.assertEquals('400', strId2);
    }
}