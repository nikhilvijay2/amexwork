public class SetClass {
    
    public List<string> myList{get;set;}
    Map<string, string> newMap;
    
    public SetClass(){
        myList = new List<string>();
        
        newMap = new Map<string, string>();
        newMap.put('Hyd', 'Nikhil');
        newMap.put('Krm', 'Harish');
        newMap.put('kmr', 'keer');
        
    }
    
    public  pageReference show(){
        
        myList.clear();
        
        set<string> keySet = newMap.keySet();
        myList.addAll(keySet);
        return null;
    }
    
    public pageReference display(){
        myList = newMap.values();
        return null;
    }

}