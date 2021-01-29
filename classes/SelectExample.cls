public class SelectExample {
    
    public selectOption[] myoptions{get;set;}
    
    public SelectExample(){
        
        SelectOption s = new SelectOption('null', 'none');
            SelectOption s1= new SelectOption('one', 'Jan');
                SelectOption s2 = new SelectOption('two', 'Feb');
        
        myoptions = new SelectOption[]{s, s1, s2};
    }
    
    

}