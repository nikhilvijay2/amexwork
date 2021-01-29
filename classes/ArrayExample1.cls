public class ArrayExample1 {
    
    public Account[] myacc{get;set;}
    
    public ArrayExample1(){
        
        Account a = new Account(Name= 'Nikhil', Industry ='Banking');
        Account a1= new Account(Name='Dingari', Industry ='Hotels');
        Account a2 = new Account(Name='Vijay', Industry='Blogger');
        
        myacc = new Account[]{a,a1,a2};
    }

}