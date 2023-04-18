@isTest
global class EventPriceBookMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest request) {

        // Create a fake HTTPResponse

        HttpResponse response = new HttpResponse();

        response.setHeader('Content-Type', 'application/json,charset-UTF-8');

        response.setBody('[{"id": 1, "title": "Product 1", "description": "Description for Product 1", "price": 9.99}, {"id": 2, "title": "Product 2", "description": "Description for Product 2", "price": 19.99}]');

        response.setStatusCode(200);

        return response;

    }

}