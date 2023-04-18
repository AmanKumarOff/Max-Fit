public class AccountTriggerHandler {
    public static void updateRating(List<Account> newlist){
        for(Account acc:newlist){
            //acc.Description='Test Desciption 123';
            if(acc.Industry!=null && acc.Industry=='Media')
                acc.Rating='Hot';
        }
	}
    public static void createRelatedlist(List<Account> newlist){
       list<opportunity> opptobeinserted=new list <opportunity>(); 
        
        for(Account acc:newlist){
            Opportunity opp=new Opportunity();
            opp.name=acc.name;
            opp.AccountId=acc.Id;
            opp.StageName='Prospecting';
            opp.closeDate=System.today();
            opptobeinserted.add(opp);
            
        }
        if(!opptobeinserted.isEmpty()){
			insert opptobeinserted;
        }
	}
    public static void updatePhoneDescription(List<Account> newlist, Map<id,Account> oldmap){
        
        for(Account acc:newlist){
            if(oldmap!=null && acc.Phone!=oldmap.get(acc.id).Phone){
                acc.Description='Phone is modified Account';
            }
        }
        
        
        
    }
}