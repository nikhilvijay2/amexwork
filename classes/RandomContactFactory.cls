public class RandomContactFactory {
    

    public static List<Contact> generateRandomContacts(Integer noOfContacts, String LastName){
        
        List<Contact> cntList = new List<Contact>();
        
        for(Integer i=0; i<noOfContacts; i++){
            Contact c = new Contact(FirstName= LastName + i);
            cntList.add(c);
        }
        
        return cntList;
        
        
        
    } 
}