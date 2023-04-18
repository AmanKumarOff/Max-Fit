public class MyAccountController {
    @auraEnabled
    public static List<contact> getContacts(Id AccountId){
        List <Contact> contactDetail =[select Id,Name,Title,email,phone from Contact where AccountId =:AccountId];
        return contactDetail;
    }
}