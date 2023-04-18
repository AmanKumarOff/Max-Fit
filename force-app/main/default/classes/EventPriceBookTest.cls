@isTest
private class EventPriceBookTest {

    @isTest
    static void testMyCallout() {

        // Set up mock callout
        Test.setMock(HttpCalloutMock.class, new EventPriceBookMock());

        // Call the method being tested
        Test.startTest();
        EventPriceBook.myCallOut();
        Test.stopTest();

        List<PricebookEntry> entries = [SELECT Id, Product2.Name, Product2Id, UnitPrice FROM PricebookEntry];

        System.assertEquals('Product 1', entries[0].Product2.Name);
        System.assertEquals(9.99, entries[0].UnitPrice);
        System.assertEquals('Product 2', entries[1].Product2.Name);
        System.assertEquals(19.99, entries[1].UnitPrice);
    }
}