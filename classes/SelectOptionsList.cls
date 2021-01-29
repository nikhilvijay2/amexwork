public class SelectOptionsList {
    
    public string myval{get;set;}
    
    public List<SelectOption> myoptions{get;set;}
    
    public List<selectOption> getOptions(){
        return myoptions;
    }
    
    public SelectOptionsList(){
        myoptions = new List<selectOption>();
        
        selectoption s = new selectoption('one', 'Jan');
        selectoption s1 = new selectoption('two', 'Feb');
        
        myoptions.add(s);
        myoptions.add(s1);
        myoptions.add(new selectoption('three', 'March'));
        myoptions.add(new selectoption('four', 'april'));
    }
    

}