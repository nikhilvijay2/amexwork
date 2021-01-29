public class contactdetail {
    
    public List<contact> cntList{get;set;}
    public pageReference show(){
        
        cntList = [select Id, Name, contact.Account.Name, contact.Account.Industry from contact Limit 5];
        return null;
    }

}