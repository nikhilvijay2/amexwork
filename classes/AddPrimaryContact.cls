public class AddPrimaryContact implements Queueable{
    
    private contact c;
    private string state;
    
    public AddPrimaryContact(Contact c, string State){
        this.c = c;
        this.state = state;
        
    }
    
    public void execute(queueableContext context){
        List<Account> accList = new List<Account>([Select Id, Name, (Select ID, name from contacts) from account 
                                                   Where BillingState =:State LIMIT 200]);
        
        List<Contact> conList = new List<Contact>();
        
        for(Account a: accList){
            contact con = c.clone(false,false,false,false);
            con.AccountId = a.Id;
            conList.add(con);
        }
        
        if(conList.size()>0){
            insert conList;
        }
        
    }

}