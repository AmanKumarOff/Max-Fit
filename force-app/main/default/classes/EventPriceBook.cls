public class EventPriceBook {
    
    public static void myCallOut(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://fakestoreapi.com/products');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200){
            
            List<Object> result = (List<Object>) JSON.deserializeUntyped(response.getBody());
            String priceBookName = 'Aman-pricebook';
            PriceBook2 priceBk = new PriceBook2(Name = priceBookName, IsActive = true);
            insert priceBk;
            
            List<PricebookEntry> priceBkEntry = new List<PricebookEntry>();
            Id standardPribookId;
            
            if(Test.isRunningTest()) {
                standardPribookId = Test.getStandardPricebookId();
            } else {
                Pricebook2 standardPribook = [Select id,name FROM Pricebook2 WHERE IsStandard = true LIMIT 1];
                standardPribookId = standardPribook.Id;
            }
            
            for(Object obj: result){
                Map<String, Object> dataNode = (Map<String, Object>)obj;
                String prodId = String.valueOf(dataNode.get('id'));
                String prodName = String.valueOf(dataNode.get('title'));
                String prodDescription = String.valueOf(dataNode.get('description'));
                String prodPrice1 = String.valueOf(dataNode.get('price'));
                Decimal prodPrice = Decimal.valueOf(prodPrice1);
                
                Product2 prod = new Product2(
                    ProductCode = prodId,
                    Name = prodName,
                    Description = prodDescription
                );
                
                insert prod;
                
                PricebookEntry priceBE = new PricebookEntry(
                    Pricebook2Id = standardPribookId,
                    Product2Id = prod.Id,
                    UnitPrice = prodPrice,
                    IsActive = true
                );
                
                insert priceBE;
                
                PricebookEntry pbe = new PricebookEntry(
                    Pricebook2Id = priceBk.Id,
                    Product2Id = prod.Id,
                    UnitPrice = prodPrice,
                    IsActive = true
                );
                
                priceBkEntry.add(pbe);
            }
            
            insert priceBkEntry;
            System.debug(priceBkEntry.size());
            
        } else {
            System.debug('API call failed with status code: ' + response.getStatusCode());
        }
    }
}