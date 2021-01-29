public class SetExample {
    
    public set<Account> newset{get;set;}
    
    public SetExample(){
        
        newset = new set<Account>();
        
        Account a = new Account(name='new', Industry='tech');
        Account a1 = new Account(name='new1', Industry='tech');
        Account a2 = new Account(name='new2', Industry='tech');
        
        newset.add(a);
        newset.add(a1);
        newset.add(a2);
        
    }

}