public class ListExample {
    
    public List<Account> result{get;set;}
    
    public ListExample(){
        
        Account a = new Account(name='Nikhil1', Industry='Bank');
        Account a1= new Account(name='Nikhil2', Industry='Bank');
        Account a2= new Account(name='Nikhil3', Industry='Bank');
        
        result = new List<Account>();
        result.add(a);
        result.add(a1);
        result.add(a2);
        
    }

}